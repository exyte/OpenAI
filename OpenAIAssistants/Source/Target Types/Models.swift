//
//  Models.swift
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

enum Models {

    case listModels
    case retrieveModel(modelId: String)
    case deleteModel(modelId: String)

}

extension Models: AccessTokenAuthorizable {

    var authorizationType: Moya.AuthorizationType? {
        .bearer
    }

}

extension Models: TargetType {

    var baseURL: URL {
        OpenAI.baseURL
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
            "OpenAI-Beta": "assistants=v2"
        ]
    }

}
