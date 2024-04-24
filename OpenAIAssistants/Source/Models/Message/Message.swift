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
