//
//  OpenAI+Assistants.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation
import Combine
import Moya

public extension OpenAI {

    func createAssistant(from payload: CreateAssistantPayload) -> AnyPublisher<Assistant, MoyaError> {
        assistantsProvider.requestPublisher(.createAssistant(payload: payload))
            .map(Assistant.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func modifyAssistant(id: String, payload: CreateAssistantPayload) -> AnyPublisher<Assistant, MoyaError> {
        assistantsProvider.requestPublisher(
            .modifyAssistant(
                assistantId: id,
                payload: payload
            )
        )
            .map(Assistant.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func deleteAssistant(id: String) -> AnyPublisher<DeletionStatus, MoyaError> {
        assistantsProvider.requestPublisher(.deleteAssistant(assistantId: id))
            .map(DeletionStatus.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func listAssistants(payload: ListPayload) -> AnyPublisher<ObjectList<Assistant>, MoyaError> {
        assistantsProvider.requestPublisher(.listAssistants(payload: payload))
            .map(ObjectList<Assistant>.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func retrieveAssistant(id: String) -> AnyPublisher<Assistant, MoyaError> {
        assistantsProvider.requestPublisher(.retrieveAssistant(assistantId: id))
            .map(Assistant.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func createAssistantFile(for assistantId: String, payload: CreateAssistantFilePayload) -> AnyPublisher<AssistantFile, MoyaError> {
        assistantsProvider.requestPublisher(
            .createAssistantFile(
                assistantId: assistantId,
                payload: payload
            )
        )
            .map(AssistantFile.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func deleteAssistantFile(id: String, from assistantId: String) -> AnyPublisher<DeletionStatus, MoyaError> {
        assistantsProvider.requestPublisher(
            .deleteAssistantFile(
                assistantId: assistantId,
                fileId: id
            )
        )
            .map(DeletionStatus.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func listAssistantFiles(from assistantId: String, payload: ListPayload) -> AnyPublisher<ObjectList<AssistantFile>, MoyaError> {
        assistantsProvider.requestPublisher(
            .listAssistantFiles(
                assistantId: assistantId,
                payload: payload
            )
        )
            .map(ObjectList<AssistantFile>.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func retrieveAssistantFile(id: String, from assistantId: String) -> AnyPublisher<AssistantFile, MoyaError> {
        assistantsProvider.requestPublisher(
            .retrieveAssistantFile(
                assistantId: assistantId,
                fileId: id
            )
        )
            .map(AssistantFile.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

}
