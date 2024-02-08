//
//  MessageCreationStepDetails.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct MessageCreationDetails: Codable {

    public let messageId: String
    
    public init(messageId: String) {
        self.messageId = messageId
    }

}
