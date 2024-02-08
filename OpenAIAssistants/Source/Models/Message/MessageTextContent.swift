//
//  MessageContentText.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct MessageTextContent: Codable {

    public let value: String
    
    public init(value: String) {
        self.value = value
    }

}
