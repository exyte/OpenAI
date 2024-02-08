//
//  RequiredAction.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct RequiredAction: Codable {

    public let type: ActionType
    public let toolCalls: [ToolCall]
    
    public init(type: ActionType, toolCalls: [ToolCall]) {
        self.type = type
        self.toolCalls = toolCalls
    }

}
