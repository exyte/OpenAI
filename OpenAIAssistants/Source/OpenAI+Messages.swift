//
//  OpenAI+Messages.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation
import Combine
import Moya

public extension OpenAI {

    func createMessage(in threadId: String, payload: CreateMessagePayload) -> AnyPublisher<Message, MoyaError> {
        messagesProvider.requestPublisher(.createMessage(threadId: threadId, payload: payload))
            .map(Message.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func listMessages(from threadId: String, payload: ListPayload) -> AnyPublisher<ObjectList<Message>, MoyaError> {
        messagesProvider.requestPublisher(
            .listMessages(
                threadId: threadId,
                payload: payload
            )
        )
            .map(ObjectList<Message>.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func retrieveMessage(id: String, from threadId: String) -> AnyPublisher<Message, MoyaError> {
        messagesProvider.requestPublisher(
            .retrieveMessage(
                threadId: threadId,
                messageId: id
            )
        )
            .map(Message.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func modifyMessage(id: String, from threadId: String, payload: ModifyPayload) -> AnyPublisher<Message, MoyaError> {
        messagesProvider.requestPublisher(
            .modifyMessage(
                threadId: threadId,
                messageId: id,
                payload: payload
            )
        )
            .map(Message.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func listMessageFiles(from messageId: String, in threadId: String, payload: ListPayload) -> AnyPublisher<ObjectList<MessageFile>, MoyaError> {
        messagesProvider.requestPublisher(
            .listMessageFiles(
                threadId: threadId,
                messageId: messageId,
                payload: payload
            )
        )
            .map(ObjectList<MessageFile>.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func retrieveMessageFile(id: String, from messageId: String, in threadId: String) -> AnyPublisher<MessageFile, MoyaError> {
        messagesProvider.requestPublisher(
            .retrieveMessageFile(
                threadId: threadId,
                messageId: messageId,
                fileId: id
            )
        )
            .map(MessageFile.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

}
