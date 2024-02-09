//
//  AssistansProvider.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
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
        URL(string: "https://api.openai.com/v1")!
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
            "OpenAI-Beta": "assistants=v1"
        ]
    }

}
