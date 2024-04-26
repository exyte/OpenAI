//
//  OpenAI+Assistants.swift
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

}
