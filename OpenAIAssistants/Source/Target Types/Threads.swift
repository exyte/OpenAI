//
//  Threads.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation
import Moya

enum Threads {

    case createThread(payload: CreateThreadPayload)
    case retreiveThread(threadId: String)
    case modifyThread(threadId: String, payload: ModifyPayload)
    case deleteThread(threadId: String)

}

extension Threads: AccessTokenAuthorizable {

    var authorizationType: Moya.AuthorizationType? {
        .bearer
    }

}

extension Threads: TargetType {

    var baseURL: URL {
        URL(string: "https://api.openai.com/v1")!
    }

    var path: String {
        switch self {
        case .createThread:
            return "/threads"
        case .retreiveThread(let threadId), .modifyThread(let threadId, _), .deleteThread(let threadId):
            return "/thread/\(threadId)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .createThread, .modifyThread:
            return .post
        case .retreiveThread:
            return .get
        case .deleteThread:
            return .delete
        }
    }

    var task: Moya.Task {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        switch self {
        case .createThread(let payload):
            return .requestCustomJSONEncodable(payload, encoder: encoder)
        case .retreiveThread:
            return .requestPlain
        case .modifyThread(_, let payload):
            return .requestCustomJSONEncodable(payload, encoder: encoder)
        case .deleteThread:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        [
            "OpenAI-Beta": "assistants=v1"
        ]
    }

}
