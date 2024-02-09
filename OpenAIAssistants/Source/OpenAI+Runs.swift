//
//  OpenAI+Runs.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation
import Combine
import Moya

public extension OpenAI {

    func createRun(in threadId: String, payload: CreateRunPayload) -> AnyPublisher<Run, MoyaError> {
        runsProvider.requestPublisher(
            .createRun(
                threadId: threadId,
                payload: payload
            )
        )
            .map(Run.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func createThreadAndRun(from payload: CreateThreadAndRunPayload) -> AnyPublisher<Run, MoyaError> {
        runsProvider.requestPublisher(.createThreadAndRun(payload: payload))
            .map(Run.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func listRuns(from threadId: String, payload: ListPayload) -> AnyPublisher<ObjectList<Run>, MoyaError> {
        runsProvider.requestPublisher(
            .listRuns(
                threadId: threadId,
                payload: payload
            )
        )
            .map(ObjectList<Run>.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func retrieveRun(id: String, from threadId: String) -> AnyPublisher<Run, MoyaError> {
        runsProvider.requestPublisher(
            .retrieveRun(
                threadId: threadId,
                runId: id
            )
        )
            .map(Run.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func modifyRun(id: String, from threadId: String, payload: ModifyPayload) -> AnyPublisher<Message, MoyaError> {
        runsProvider.requestPublisher(
            .modifyRun(
                threadId: threadId,
                runId: id,
                payload: payload
            )
        )
            .map(Message.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func cancelRun(id: String, from threadId: String) -> AnyPublisher<Message, MoyaError> {
        runsProvider.requestPublisher(
            .cancelRun(
                threadId: threadId,
                runId: id
            )
        )
            .map(Message.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func submitToolOutputs(to runId: String, from threadId: String, payload: SubmitToolOutputsPayload) -> AnyPublisher<Run, MoyaError> {
        runsProvider.requestPublisher(
            .submitToolOutputs(
                threadId: threadId,
                runId: runId,
                payload: payload
            )
        )
            .map(Run.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func listRunSteps(from runId: String, in threadId: String, payload: ListPayload) -> AnyPublisher<ObjectList<RunStep>, MoyaError> {
        runsProvider.requestPublisher(
            .listRunSteps(
                threadId: threadId,
                runId: runId,
                payload: payload
            )
        )
            .map(ObjectList<RunStep>.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func retrieveRunStep(id: String, from runId: String, in threadId: String) -> AnyPublisher<Run, MoyaError> {
        runsProvider.requestPublisher(
            .retrieveRunStep(
                threadId: threadId,
                runId: runId,
                runStepId: id
            )
        )
            .map(Run.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

}
