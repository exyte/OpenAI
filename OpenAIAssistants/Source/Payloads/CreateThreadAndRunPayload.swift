//
//  CreateThreadAndRunPayload.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct CreateThreadAndRunPayload: Codable {

    public let assistandId: String
    public let thread: CreateThreadPayload
    public let model: ModelType?
    public let instructions: String?
    public let tools: [Tool]?
    public let metadata: [String: String]?
    
    public init(
        assistandId: String,
        thread: CreateThreadPayload,
        model: ModelType? = nil,
        instructions: String? = nil,
        tools: [Tool]? = nil,
        metadata: [String : String]? = nil
    ) {
        self.assistandId = assistandId
        self.thread = thread
        self.model = model
        self.instructions = instructions
        self.tools = tools
        self.metadata = metadata
    }

}
