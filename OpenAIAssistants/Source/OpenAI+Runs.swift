//
//  OpenAI+Runs.swift
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
