//
//  SubmitToolOutputsPayload.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct SubmitToolOutputsPayload: Codable {

    public let toolOutputs: [ToolOutput]
    
    public init(toolOutputs: [ToolOutput]) {
        self.toolOutputs = toolOutputs
    }

}
