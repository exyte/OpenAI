//
//  RunStepType.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public enum RunStepType: String, Codable {

    case messageCreation = "message_creation"
    case toolCalls = "tool_calls"

}
