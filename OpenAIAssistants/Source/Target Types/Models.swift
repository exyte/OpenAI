//
//  Models.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation
import Moya

enum Models {

    case listModels
    case retrieveModel(modelId: String)
    case deleteModel(modelId: String)

}

extension Models: TargetType {

    var baseURL: URL {
        URL(string: "https://api.openai.com/v1")!
    }

    var path: String {
        switch self {
        case .listModels:
            return "/models"
        case .retrieveModel(let modelId), .deleteModel(let modelId):
            return "/models/\(modelId)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .listModels, .retrieveModel:
            return .get
        case .deleteModel:
            return .delete
        }
    }

    var task: Moya.Task {
        return .requestPlain
    }

    var headers: [String: String]? {
        [
            "OpenAI-Beta": "assistants=v1"
        ]
    }

}
