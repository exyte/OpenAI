//
//  Provider.swift
//
//  Copyright (c) 2024 Exyte
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
import Combine

open class Provider<T: EndpointConfiguration> {
    
    private let mandatoryHeaders: [HTTPHeader]
    
    public init(with apiKey: String) {
        mandatoryHeaders = [
            .authorization(bearerToken: apiKey),
            .openAIBeta(value: "assistants=v2")
        ]
    }
    
    open func requestPublisher(for endpoint: T) -> AnyPublisher<URLSession.DataTaskPublisher.Output, OpenAIError> {
        createRequestPublisher(for: endpoint)
            .flatMap { [weak self] in
                guard let self else {
                    return Fail<URLSession.DataTaskPublisher.Output, OpenAIError>(error: OpenAIError.requestCreationFailed)
                        .eraseToAnyPublisher()
                }
                return self.dataTaskPublisher(for: $0)
            }
            .eraseToAnyPublisher()
    }
    
    open func downloadPublisher(for endpoint: T) -> AnyPublisher<URL, OpenAIError> {
        guard case let .download(_, destinationURL) = endpoint.task else {
            return Fail<URL, OpenAIError>(error: OpenAIError.incompatibleRequestTask)
                .eraseToAnyPublisher()
        }
        return createRequestPublisher(for: endpoint)
            .flatMap { [weak self] in
                guard let self else {
                    return Fail<URL, OpenAIError>(error: OpenAIError.requestCreationFailed)
                        .eraseToAnyPublisher()
                }
                return self.downloadTaskPublisher(for: $0, with: destinationURL)
            }
            .eraseToAnyPublisher()
    }
    
    private func downloadTaskPublisher(for request: URLRequest, with destinationURL: URL) -> AnyPublisher<URL, OpenAIError> {
        Future<URL, OpenAIError> { [weak self] promise in
            guard let self else {
                promise(.failure(.requestCreationFailed))
                return
            }
            URLSession.shared.downloadTask(with: request) { url, response, error in
                if let error {
                    promise(.failure(OpenAIError.requestFailed(underlyingError: error)))
                    return
                }
                guard let response = response as? HTTPURLResponse else {
                    promise(.failure(OpenAIError.emptyResponse))
                    return
                }
                let statusCode = response.statusCode
                guard 200...299 ~= response.statusCode else {
                    promise(.failure(OpenAIError.statusCode(code: statusCode, response: response, responseError: nil)))
                    return
                }
                guard let url else {
                    promise(.failure(OpenAIError.emptyFileURL))
                    return
                }
                do {
                    try FileManager.default.moveItem(at: url, to: destinationURL)
                    promise(.success(destinationURL))
                } catch {
                    promise(.failure(.saveFailed(error.localizedDescription)))
                }
            }
            .resume()
        }.eraseToAnyPublisher()
    }
    
    private func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<URLSession.DataTaskPublisher.Output, OpenAIError> {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result in
                guard let response = result.response as? HTTPURLResponse else {
                    throw OpenAIError.emptyResponse
                }
                let statusCode = response.statusCode
                guard 200...299 ~= response.statusCode else {
                    guard let error = try JSONDecoder().decode([String: OpenAIResponseError].self, from: result.data).values.first else {
                        throw OpenAIError.statusCode(code: statusCode, response: response, responseError: nil)
                    }
                    throw OpenAIError.statusCode(code: statusCode, response: response, responseError: error)
                    
                }
                return result
            }
            .mapError { error -> OpenAIError in
                switch error {
                case let apiError as OpenAIError:
                    return apiError
                case let urlError as URLError:
                    return OpenAIError.requestFailed(underlyingError: urlError)
                default:
                    return OpenAIError.underlying(error)
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func createRequestPublisher(for endpoint: T) -> AnyPublisher<URLRequest, OpenAIError> {
        Future<URLRequest, OpenAIError> { [weak self] promise in
            guard let self else {
                promise(.failure(.requestCreationFailed))
                return
            }
            let url = OpenAI.baseURL.appending(path: endpoint.path)
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = endpoint.method.rawValue
            switch endpoint.task {
            case .plain:
                urlRequest.allHTTPHeaderFields = mandatoryHeaders.dictionary
                promise(.success(urlRequest))
            case .JSONEncodable(let encodable):
                var headers = mandatoryHeaders
                headers.append(.contentType(value: MimeType.json))
                urlRequest.allHTTPHeaderFields = headers.dictionary
                let encoder = JSONEncoder()
                encoder.keyEncodingStrategy = .convertToSnakeCase
                do {
                    let data = try encoder.encode(encodable)
                    urlRequest.httpBody = data
                    promise(.success(urlRequest))
                } catch {
                    promise(.failure(.encodingFailed(underlyingError: error)))
                }
            case .URLParametersEncodable(let encodable):
                urlRequest.allHTTPHeaderFields = mandatoryHeaders.dictionary
                let encoder = JSONEncoder()
                encoder.keyEncodingStrategy = .convertToSnakeCase
                let parameters: [String: Any]
                do {
                    let data = try encoder.encode(encodable)
                    parameters = (try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]) ?? [:]
                    guard !parameters.isEmpty else {
                        promise(.success(urlRequest))
                        return
                    }
                    guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
                        promise(.failure(.encodingFailed(underlyingError: nil)))
                        return
                    }
                    let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? "") + parameters.map { "\($0)=\($1)" }.joined(separator: "&")
                    urlComponents.percentEncodedQuery = percentEncodedQuery
                    urlRequest.url = urlComponents.url
                    promise(.success(urlRequest))
                } catch {
                    promise(.failure(.encodingFailed(underlyingError: error)))
                }
            case .uploadMultipart(let formData):
                do {
                    let multipartBody = try self.createMultipartBody(with: formData)
                    var headers = mandatoryHeaders
                    headers.append(.contentType(value: multipartBody.contentType))
                    urlRequest.allHTTPHeaderFields = headers.dictionary
                    urlRequest.httpBody = multipartBody.body
                    promise(.success(urlRequest))
                } catch {
                    switch error {
                    case let apiError as OpenAIError:
                        promise(.failure(apiError))
                    default:
                        promise(.failure(OpenAIError.underlying(error)))
                    }
                }
            case .download(let encodable, _):
                if let encodable {
                    var headers = mandatoryHeaders
                    headers.append(.contentType(value: MimeType.json))
                    urlRequest.allHTTPHeaderFields = headers.dictionary
                    let encoder = JSONEncoder()
                    encoder.keyEncodingStrategy = .convertToSnakeCase
                    do {
                        let data = try encoder.encode(encodable)
                        urlRequest.httpBody = data
                        promise(.success(urlRequest))
                    } catch {
                        promise(.failure(.encodingFailed(underlyingError: error)))
                    }
                }
                promise(.success(urlRequest))
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func createMultipartBody(with bodyParts: [FormBodyPart]) throws -> (contentType: String, body: Data) {
        var body = Data()

        let boundary = "Boundary-\(UUID().uuidString)"
        let boundaryPrefix = "--\(boundary)\r\n"
        let crlf = "\r\n"
        
        guard let boundaryPrefixData = boundaryPrefix.data(using: .utf8) else {
            throw OpenAIError.multipartEncoding(encodingError: .dataEncodingFailed)
        }
        
        try bodyParts.forEach {
            body.append(boundaryPrefixData)
            var contentDisposition = "Content-Disposition: form-data; name=\"\($0.name)\""
            if let fileName = $0.fileName {
                contentDisposition.append("; filename=\"\(fileName)\"")
            }
            contentDisposition.append(crlf)
            guard let contentDispositionData = contentDisposition.data(using: .utf8) else {
                throw OpenAIError.multipartEncoding(encodingError: .dataEncodingFailed)
            }
            body.append(contentDispositionData)
            let mimeType: String
            let bodyData: Data
            switch $0.value {
            case .data(let data):
                mimeType = $0.mimeType ?? MimeType.unknownBinary
                bodyData = data
            case .fileURL(let url):
                mimeType = $0.mimeType ?? url.mimeType
                guard url.isFileURL else {
                    throw OpenAIError.multipartEncoding(encodingError: .invalidBodyPartURL)
                }
                guard try url.checkPromisedItemIsReachable() else {
                    throw OpenAIError.multipartEncoding(encodingError: .fileNotReachable)
                }
                bodyData = try Data(contentsOf: url)
            case .plainText(let text):
                mimeType = $0.mimeType ?? MimeType.text
                guard let textData = text.data(using: .utf8) else {
                    throw OpenAIError.multipartEncoding(encodingError: .dataEncodingFailed)
                }
                bodyData = textData
            case .floatingPoint(let float):
                mimeType = $0.mimeType ?? MimeType.unknownBinary
                let encoder = JSONEncoder()
                encoder.keyEncodingStrategy = .convertToSnakeCase
                do {
                    let numberData = try encoder.encode(float)
                    bodyData = numberData
                } catch {
                    throw OpenAIError.multipartEncoding(encodingError: .dataEncodingFailed)
                }
            case .integer(let integer):
                mimeType = $0.mimeType ?? MimeType.unknownBinary
                let encoder = JSONEncoder()
                encoder.keyEncodingStrategy = .convertToSnakeCase
                do {
                    let numberData = try encoder.encode(integer)
                    bodyData = numberData
                } catch {
                    throw OpenAIError.multipartEncoding(encodingError: .dataEncodingFailed)
                }
            }
            body.append("Content-Type: \(mimeType)\(crlf)\(crlf)".data(using: String.Encoding.utf8)!)
            body.append(bodyData)
            body.append("\r\n".data(using: String.Encoding.utf8)!)
        }
        body.append("--\(boundary)--\(crlf)".data(using: String.Encoding.utf8)!)

        return (
            contentType: "multipart/form-data; boundary=\(boundary)",
            body: body
        )
    }
    
}
