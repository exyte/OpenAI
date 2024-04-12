//
//  Messages.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation
import Moya

enum Messages {

    case createMessage(threadId: String, payload: CreateMessagePayload)
    case listMessages(threadId: String, payload: ListPayload)
    case retrieveMessage(threadId: String, messageId: String)
    case retrieveMessageFile(threadId: String, messageId: String, fileId: String)
    case modifyMessage(threadId: String, messageId: String, payload: ModifyPayload)
    case listMessageFiles(threadId: String, messageId: String, payload: ListPayload)
}

extension Messages: AccessTokenAuthorizable {

    var authorizationType: Moya.AuthorizationType? {
        .bearer
    }

}

extension Messages: TargetType {

    var baseURL: URL {
        URL(string: "https://api.openai.com/v1")!
    }

    var path: String {
        switch self {
        case .createMessage(let threadId, _), .listMessages(let threadId, _):
            return "threads/\(threadId)/messages"
        case .retrieveMessage(let threadId, let messageId), .modifyMessage(let threadId, let messageId, _):
            return "threads/\(threadId)/messages/\(messageId)"
        case .listMessageFiles(let threadId, let messageId, _):
            return "threads/\(threadId)/messages/\(messageId)/files"
        case .retrieveMessageFile(let threadId, let messageId, let fileId):
            return "threads/\(threadId)/messages/\(messageId)/files/\(fileId)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .createMessage, .modifyMessage:
            return .post
        case .retrieveMessage, .retrieveMessageFile, .listMessages, .listMessageFiles:
            return .get
        }
    }

    var task: Moya.Task {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        switch self {
        case .createMessage(_, let payload):
            return .requestCustomJSONEncodable(payload, encoder: encoder)
        case .listMessages(_, let payload), .listMessageFiles(_, _, let payload):
            let parameters: [String: Any]
            if let data = try? encoder.encode(payload) {
                parameters = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
                    .flatMap { $0 as? [String: Any] } ?? [:]
            } else {
                parameters = [:]
            }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .modifyMessage(_, _, let payload):
            return .requestCustomJSONEncodable(payload, encoder: encoder)
        case .retrieveMessage, .retrieveMessageFile:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        [
            "OpenAI-Beta": "assistants=v1"
        ]
    }

}
