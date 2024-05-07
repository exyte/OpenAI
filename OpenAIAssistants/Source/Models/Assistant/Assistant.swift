//
//  Assistant.swift
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

public struct Assistant: Codable {

    public let id: String
    public let object: String
    public let createdAt: Date
    public let name: String?
    public let description: String?
    public let model: ModelType
    public let instructions: String?
    public let tools: [Tool]?
    public let metadata: [String: String]
    public let toolResources: ToolResources

    public init(
        id: String,
        object: String,
        createdAt: Date,
        name: String? = nil,
        description: String? = nil,
        model: ModelType,
        instructions: String? = nil,
        tools: [Tool]? = nil,
        metadata: [String : String],
        toolResources: ToolResources
    ) {
        self.id = id
        self.object = object
        self.createdAt = createdAt
        self.name = name
        self.description = description
        self.model = model
        self.instructions = instructions
        self.tools = tools
        self.metadata = metadata
        self.toolResources = toolResources
    }

}

public struct ToolResources: Codable {

    public let fileSearch: FileSearch?
    public let codeInterpreter: CodeInterpreter?

    public init(
        fileSearch: FileSearch? = nil,
        codeInterpreter: CodeInterpreter? = nil
    ) {
        self.fileSearch = fileSearch
        self.codeInterpreter = codeInterpreter
    }

}

public struct CodeInterpreter: Codable {

    public let fileIDS: [String]

    public init(fileIDS: [String]) {
        self.fileIDS = fileIDS
    }

}

public struct FileSearch: Codable {

    public let vectorStoreIDS: [String]

    public init(vectorStoreIDS: [String]) {
        self.vectorStoreIDS = vectorStoreIDS
    }

}
