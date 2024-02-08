//
//  ToolCall.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct ToolCall: Codable {

    public let id: String
    public let type: ToolType
    public let function: Function

    public init(id: String, type: ToolType, function: Function) {
        self.id = id
        self.type = type
        self.function = function
    }

}
