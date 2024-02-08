//
//  Assistant.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct Assistant: Codable {

    public let id: String
    public let object: String
    public let createdAt: Date
    public let name: String?
    public let description: String?
    public let model: String
    public let instructions: String?
    public let tools: [Tool]
    public let fileIds: [String]
    public let metadata: [String: String]
    
    public init(
        id: String,
        object: String,
        createdAt: Date,
        name: String? = nil,
        description: String? = nil,
        model: String,
        instructions: String? = nil,
        tools: [Tool],
        fileIds: [String],
        metadata: [String : String]
    ) {
        self.id = id
        self.object = object
        self.createdAt = createdAt
        self.name = name
        self.description = description
        self.model = model
        self.instructions = instructions
        self.tools = tools
        self.fileIds = fileIds
        self.metadata = metadata
    }

}
