//
//  ToolOutput.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct ToolOutput: Codable {

    public let toolCallId: String?
    public let output: String?

    public init(toolCallId: String? = nil, output: String? = nil) {
        self.toolCallId = toolCallId
        self.output = output
    }

}
