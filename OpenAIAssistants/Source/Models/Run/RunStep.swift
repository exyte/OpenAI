//
//  RunStep.swift
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
