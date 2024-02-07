//
//  CreateAssistantPayload.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct CreateAssistantPayload: Codable {

    public let model: ModelType
    public let name: String?
    public let description: String?
    public let instructions: String?
    public let tools: [Tool]?
    public let fileIds: [String]?
    public let metadata: [String: String]?
    
    public init(
        model: ModelType,
        name: String? = nil,
        description: String? = nil,
        instructions: String? = nil,
        tools: [Tool]? = nil,
        fileIds: [String]? = nil,
        metadata: [String : String]? = nil
    ) {
        self.model = model
        self.name = name
        self.description = description
        self.instructions = instructions
        self.tools = tools
        self.fileIds = fileIds
        self.metadata = metadata
    }
    
}
