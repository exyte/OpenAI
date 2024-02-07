//
//  Run.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct Run: Codable {

    public let id: String
    public let object: String
    public let createdAt: Date
    public let threadId: String
    public let assistantId: String
    public let status: RunStatus
    public let requiredAction: RequiredAction?
    public let lastError: RunError?
    public let expiresAt: Date
    public let startedAt: Date?
    public let cancelledAt: Date?
    public let failedAt: Date?
    public let completedAt: Date?
    public let model: ModelType
    public let instructions: String
    public let tools: [Tool]
    public let fileIds: [String]
    public let metadata: [String: String]?
    public let usage: UsageStatistics?
    
    public init(
        id: String,
        object: String,
        createdAt: Date,
        threadId: String,
        assistantId: String,
        status: RunStatus,
        requiredAction: RequiredAction? = nil,
        lastError: RunError? = nil,
        expiresAt: Date,
        startedAt: Date? = nil,
        cancelledAt: Date? = nil,
        failedAt: Date? = nil,
        completedAt: Date? = nil,
        model: ModelType,
        instructions: String,
        tools: [Tool],
        fileIds: [String],
        metadata: [String : String]? = nil,
        usage: UsageStatistics? = nil
    ) {
        self.id = id
        self.object = object
        self.createdAt = createdAt
        self.threadId = threadId
        self.assistantId = assistantId
        self.status = status
        self.requiredAction = requiredAction
        self.lastError = lastError
        self.expiresAt = expiresAt
        self.startedAt = startedAt
        self.cancelledAt = cancelledAt
        self.failedAt = failedAt
        self.completedAt = completedAt
        self.model = model
        self.instructions = instructions
        self.tools = tools
        self.fileIds = fileIds
        self.metadata = metadata
        self.usage = usage
    }

}
