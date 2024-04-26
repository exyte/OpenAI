//
//  Files.swift
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
import Moya

enum Files {
    case uploadFile(payload: FilePayload)
    case listFiles
    case retrieveFile(id: String)
    case deleteFile(id: String)
    case retrieveFileContent(id: String)
}

extension Files: AccessTokenAuthorizable {

    var authorizationType: Moya.AuthorizationType? {
        .bearer
    }
}

extension Files: TargetType {

    var baseURL: URL {
        OpenAI.baseURL
    }

    var path: String {
        switch self {
        case .uploadFile, .listFiles:
            return "files"
        case .retrieveFile(let id), .deleteFile(let id):
            return "files/\(id)"
        case .retrieveFileContent(let id):
            return "files/\(id)/content"
        }
    }

    var method: Moya.Method {
        switch self {
        case .uploadFile:
            return .post
        case .listFiles, .retrieveFile, .retrieveFileContent:
            return .get
        case .deleteFile:
            return .delete
        }
    }

    var task: Moya.Task {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        switch self {
        case .uploadFile(let payload):
            let formData: [MultipartFormData] = [
                MultipartFormData(provider: .file(payload.fileURL), name: "file", fileName: payload.fileURL.lastPathComponent),
                MultipartFormData(provider: .data(payload.purpose.data(using: .utf8)!), name: "purpose")
            ]
            return .uploadMultipart(formData)

        case .listFiles, .retrieveFile, .deleteFile:
            return .requestPlain
        case .retrieveFileContent:

            let defaultDownloadDestination: DownloadDestination = { temporaryURL, response in

                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileURL = documentsURL.appendingPathComponent(response.suggestedFilename!)
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }

            return .downloadDestination(defaultDownloadDestination)
        }
    }

    var headers: [String: String]? {
        [
            "OpenAI-Beta": "assistants=v2"
        ]
    }

}
