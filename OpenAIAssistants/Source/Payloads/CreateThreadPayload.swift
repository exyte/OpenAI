//
//  CreateThreadPayload.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct CreateThreadPayload: Codable {

    public let messages: [CreateMessagePayload]
    public let metadata: [String: String]
    
    public init(messages: [CreateMessagePayload], metadata: [String : String]) {
        self.messages = messages
        self.metadata = metadata
    }

}
