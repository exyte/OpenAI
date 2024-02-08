//
//  RunStepDetails.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct RunStepDetails: Codable {

    public let type: RunStepType
    public let messageCreation: MessageCreationDetails
    public let toolCalls: [ToolCall]
    
    public init(
        type: RunStepType,
        messageCreation: MessageCreationDetails,
        toolCalls: [ToolCall]
    ) {
        self.type = type
        self.messageCreation = messageCreation
        self.toolCalls = toolCalls
    }

}
