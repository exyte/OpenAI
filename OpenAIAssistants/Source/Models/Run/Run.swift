//
//  Run.swift
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

public struct Run: Codable {

    public let id: String
    public let object: String
    public let createdAt: Date
    public let threadId: String
    public let assistantId: String
    public let status: RunStatus
    public let requiredAction: RequiredAction?
    public let lastError: RunError?
    public let expiresAt: Date?
    public let startedAt: Date?
    public let cancelledAt: Date?
    public let failedAt: Date?
    public let completedAt: Date?
    public let model: ModelType
    public let instructions: String
    public let tools: [Tool]
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
        expiresAt: Date? = nil,
        startedAt: Date? = nil,
        cancelledAt: Date? = nil,
        failedAt: Date? = nil,
        completedAt: Date? = nil,
        model: ModelType,
        instructions: String,
        tools: [Tool],
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
        self.metadata = metadata
        self.usage = usage
    }

}
