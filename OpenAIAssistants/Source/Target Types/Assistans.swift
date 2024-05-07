//
//  AssistansProvider.swift
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

enum Assistans {

    case createAssistant(payload: CreateAssistantPayload)
    case listAssistants(payload: ListPayload)
    case retrieveAssistant(assistantId: String)
    case modifyAssistant(assistantId: String, payload: CreateAssistantPayload)
    case deleteAssistant(assistantId: String)
    case createAssistantFile(assistantId: String, payload: CreateAssistantFilePayload)
    case listAssistantFiles(assistantId: String, payload: ListPayload)
    case retrieveAssistantFile(assistantId: String, fileId: String)
    case deleteAssistantFile(assistantId: String, fileId: String)

}

extension Assistans: AccessTokenAuthorizable {

    var authorizationType: Moya.AuthorizationType? {
        .bearer
    }

}

extension Assistans: TargetType {

    var baseURL: URL {
        OpenAI.baseURL
    }

    var path: String {
        switch self {
        case .createAssistant, .listAssistants:
            return "/assistants"
        case .retrieveAssistant(let assistantId), .modifyAssistant(let assistantId, _), .deleteAssistant(let assistantId):
            return "/assistants/\(assistantId)"
        case .listAssistantFiles(let assistantId, _), .createAssistantFile(let assistantId, _):
            return "/assistants/\(assistantId)/files"
        case .retrieveAssistantFile(let assistantId, let fileId), .deleteAssistantFile(let assistantId, let fileId):
            return "/assistants/\(assistantId)/files/\(fileId)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .createAssistant, .modifyAssistant, .createAssistantFile:
            return .post
        case .listAssistants, .listAssistantFiles, .retrieveAssistant, .retrieveAssistantFile:
            return .get
        case .deleteAssistant, .deleteAssistantFile:
            return .delete
        }
    }

    var task: Moya.Task {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        switch self {
        case .createAssistant(let payload):
            return .requestCustomJSONEncodable(payload, encoder: encoder)
        case .listAssistants(let payload), .listAssistantFiles(_, let payload):
            let parameters: [String: Any]
            if let data = try? encoder.encode(payload) {
                parameters = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
                    .flatMap { $0 as? [String: Any] } ?? [:]
            } else {
                parameters = [:]
            }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .modifyAssistant(_, let payload):
            return .requestCustomJSONEncodable(payload, encoder: encoder)
        case .retrieveAssistant, .deleteAssistant, .retrieveAssistantFile, .deleteAssistantFile:
            return .requestPlain
        case .createAssistantFile(_, let payload):
            return .requestCustomJSONEncodable(payload, encoder: encoder)
        }
    }

    var headers: [String: String]? {
        [
            "OpenAI-Beta": "assistants=v2"
        ]
    }

}
