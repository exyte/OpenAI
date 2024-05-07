//
//  Message.swift
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

public enum MessageStatus: String, Codable {

    case inProgress = "in_progress"
    case inComplete = "incomplete"
    case completed = "completed"

}

public struct Message: Codable {

    public let id: String
    public let object: String
    public let createdAt: Date
    public let threadId: String
    public let status: MessageStatus?
    public let incompleteDetails: IncompleteDetails?
    public let completedAt: Int?
    public let incompleteAt: Int?
    public let role: MessageRole
    public let content: [MessageContent]
    public let assistantId: String?
    public let runId: String?
    public let metadata: [String: String]?
    public let attachments: [Attachment]?

    public init(
        id: String,
        object: String,
        createdAt: Date,
        threadId: String,
        status: MessageStatus? = nil,
        incompleteDetails: IncompleteDetails? = nil,
        completedAt: Int? = nil,
        incompleteAt: Int? = nil,
        role: MessageRole,
        content: [MessageContent],
        assistantId: String? = nil,
        runId: String? = nil,
        metadata: [String : String]? = nil,
        attachments: [Attachment]? = nil
    ) {
        self.id = id
        self.object = object
        self.createdAt = createdAt
        self.threadId = threadId
        self.status = status
        self.incompleteDetails = incompleteDetails
        self.completedAt = completedAt
        self.incompleteAt = incompleteAt
        self.role = role
        self.content = content
        self.assistantId = assistantId
        self.runId = runId
        self.metadata = metadata
        self.attachments = attachments
    }

}

public struct IncompleteDetails: Codable {

    public let reason: String

    public init(reason: String) {
        self.reason = reason
    }

}

public struct Annotations: Codable {

    public let type: String
    public let text: String
    public let startIndex: Int
    public let endIndex: Int
    public let fileCitation: Citation?
    public let filePath: Citation?

    public init(
        type: String,
        text: String,
        startIndex: Int,
        endIndex: Int,
        fileCitation: Citation? = nil,
        filePath: Citation? = nil
    ) {
        self.type = type
        self.text = text
        self.startIndex = startIndex
        self.endIndex = endIndex
        self.fileCitation = fileCitation
        self.filePath = filePath
    }

}

public struct Citation: Codable {

    public let fileId: String?
    public let filePath: String?
    public let quote: String?

    public init(
        fileId: String? = nil,
        filePath: String? = nil,
        quote: String? = nil
    ) {
        self.fileId = fileId
        self.filePath = filePath
        self.quote = quote
    }

}
