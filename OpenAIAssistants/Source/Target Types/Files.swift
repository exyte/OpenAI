//
//  File.swift
//
//
//  Created by vadim.vitkovskiy on 12.04.2024.
//

import Foundation
import Moya

enum Files {
    case uploadFile(payload: FilePayload)
    case listFiles
}

extension Files: AccessTokenAuthorizable {

    var authorizationType: Moya.AuthorizationType? {
        .bearer
    }
}

extension Files: TargetType {

    var baseURL: URL {
        URL(string: "https://api.openai.com/v1")!
    }

    var path: String {
        switch self {
        case .uploadFile, .listFiles:
            return "files"
        }
    }

    var method: Moya.Method {
        switch self {
        case .uploadFile:
            return .post
        case .listFiles:
            return .get
        }
    }

    var task: Moya.Task {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        switch self {
        case .uploadFile(let payload):
            return .requestCustomJSONEncodable(payload, encoder: encoder)
        case .listFiles:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        [
            "OpenAI-Beta": "assistants=v1"
        ]
    }

}
