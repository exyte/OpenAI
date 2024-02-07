//
//  RunStep.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct RunStep: Codable {

    public let id: String
    public let object: String
    public let createdAt: Date
    public let assistantId: String
    public let threadId: String
    public let runId: String
    public let type: RunStepType
    public let status: RunStatus
    public let stepDetails: RunStepDetails
    public let lastError: RunError?
    public let expiredAt: Date?
    public let cancelledAt: Date?
    public let failedAt: Date?
    public let completedAt: Date?
    public let metadata: [String: String]
    public let usage: UsageStatistics?
    
    public init(
        id: String,
        object: String,
        createdAt: Date,
        assistantId: String,
        threadId: String,
        runId: String,
        type: RunStepType,
        status: RunStatus,
        stepDetails: RunStepDetails,
        lastError: RunError? = nil,
        expiredAt: Date? = nil,
        cancelledAt: Date? = nil,
        failedAt: Date? = nil,
        completedAt: Date? = nil,
        metadata: [String : String],
        usage: UsageStatistics? = nil
    ) {
        self.id = id
        self.object = object
        self.createdAt = createdAt
        self.assistantId = assistantId
        self.threadId = threadId
        self.runId = runId
        self.type = type
        self.status = status
        self.stepDetails = stepDetails
        self.lastError = lastError
        self.expiredAt = expiredAt
        self.cancelledAt = cancelledAt
        self.failedAt = failedAt
        self.completedAt = completedAt
        self.metadata = metadata
        self.usage = usage
    }

}
