//
//  Runs.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation
import Moya

enum Runs {

    case createThreadAndRun(payload: CreateThreadAndRunPayload)
    case createRun(threadId: String, payload: CreateRunPayload)
    case listRuns(threadId: String, payload: ListPayload)
    case listRunSteps(threadId: String, runId: String, payload: ListPayload)
    case retrieveRun(threadId: String, runId: String)
    case retrieveRunStep(threadId: String, runId: String, runStepId: String)
    case modifyRun(threadId: String, runId: String, payload: ModifyPayload)
    case cancelRun(threadId: String, runId: String)
    case submitToolOutputs(threadId: String, runId: String, payload: SubmitToolOutputsPayload)

}

extension Runs: TargetType {

    var baseURL: URL {
        URL(string: "https://api.openai.com/v1")!
    }

    var path: String {
        switch self {
        case .createThreadAndRun:
            return "threads/runs"
        case .createRun(let threadId, _), .listRuns(let threadId, _):
            return "threads/\(threadId)/runs"
        case .retrieveRun(let threadId, let runId), .modifyRun(let threadId, let runId, _):
            return "threads/\(threadId)/runs/\(runId)"
        case .cancelRun(let threadId, let runId):
            return "threads/\(threadId)/runs/\(runId)/cancel"
        case .listRunSteps(let threadId, let runId, _):
            return "/threads/\(threadId)/runs/\(runId)/steps"
        case .retrieveRunStep(let threadId, let runId, let runStepId):
            return "/threads/\(threadId)/runs/\(runId)/steps/\(runStepId)"
        case .submitToolOutputs(let threadId, let runId, _):
            return "/threads/\(threadId)/runs/\(runId)/submit_tool_outputs"
        }
    }

    var method: Moya.Method {
        switch self {
        case .createThreadAndRun, .createRun, .modifyRun, .cancelRun, .submitToolOutputs:
            return .post
        case .retrieveRun, .retrieveRunStep, .listRuns, .listRunSteps:
            return .get
        }
    }

    var task: Moya.Task {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        switch self {
        case .createThreadAndRun(let payload):
            return .requestCustomJSONEncodable(payload, encoder: encoder)
        case .createRun(_, let payload):
            return .requestCustomJSONEncodable(payload, encoder: encoder)
        case .submitToolOutputs(_, _, let payload):
            return .requestCustomJSONEncodable(payload, encoder: encoder)
        case .listRuns(_, let payload), .listRunSteps(_, _, let payload):
            let parameters: [String: Any]
            if let data = try? encoder.encode(payload) {
                parameters = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
                    .flatMap { $0 as? [String: Any] } ?? [:]
            } else {
                parameters = [:]
            }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .modifyRun(_, _, let payload):
            return .requestCustomJSONEncodable(payload, encoder: encoder)
        case .retrieveRun, .retrieveRunStep, .cancelRun:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        [
            "OpenAI-Beta": "assistants=v1"
        ]
    }

}
