//
//  CreateRunPayload.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct CreateRunPayload: Codable {

    public let assistantId: String
    public let model: String?
    public let instructions: String?
    public let additionalInstructions: String?
    public let tools: [Tool]?
    public let metadata: [String: String]?
    
    public init(
        assistantId: String,
        model: String? = nil,
        instructions: String? = nil,
        additionalInstructions: String? = nil,
        tools: [Tool]? = nil,
        metadata: [String : String]? = nil
    ) {
        self.assistantId = assistantId
        self.model = model
        self.instructions = instructions
        self.additionalInstructions = additionalInstructions
        self.tools = tools
        self.metadata = metadata
    }

}
