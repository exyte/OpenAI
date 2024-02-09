//
//  Message.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct Message: Codable {

    public let id: String
    public let object: String
    public let createdAt: Date
    public let threadId: String
    public let role: MessageRole
    public let content: [MessageContent]
    public let assistantId: String?
    public let runId: String?
    public let fileIds: [String]?
    public let metadata: [String: String]?
    
    public init(
        id: String,
        object: String,
        createdAt: Date,
        threadId: String,
        role: MessageRole,
        content: [MessageContent],
        assistantId: String? = nil,
        runId: String? = nil,
        fileIds: [String]? = nil,
        metadata: [String : String]? = nil) {
        self.id = id
        self.object = object
        self.createdAt = createdAt
        self.threadId = threadId
        self.role = role
        self.content = content
        self.assistantId = assistantId
        self.runId = runId
        self.fileIds = fileIds
        self.metadata = metadata
    }

}
