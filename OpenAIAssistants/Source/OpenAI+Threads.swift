//
//  OpenAI+Threads.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation
import Combine
import Moya

public extension OpenAI {

    func createThread(from payload: CreateThreadPayload) -> AnyPublisher<Thread, MoyaError> {
        threadsProvider.requestPublisher(.createThread(payload: payload))
            .map(Thread.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func retrieveThread(id: String) -> AnyPublisher<Thread, MoyaError> {
        threadsProvider.requestPublisher(.retrieveThread(threadId: id))
            .map(Thread.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func modifyThread(id: String, payload: ModifyPayload) -> AnyPublisher<Thread, MoyaError> {
        threadsProvider.requestPublisher(
            .modifyThread(
                threadId: id,
                payload: payload
            )
        )
            .map(Thread.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func deleteThread(id: String) -> AnyPublisher<DeletionStatus, MoyaError> {
        modelsProvider.requestPublisher(.deleteModel(modelId: id))
            .map(DeletionStatus.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

}
