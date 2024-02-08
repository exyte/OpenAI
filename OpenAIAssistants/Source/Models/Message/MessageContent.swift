//
//  MessageContent.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct MessageContent: Codable {

    public let type: MessageContentType
    public let imageFile: MessageImageContent?
    public let text: MessageTextContent?
    
    public init(
        type: MessageContentType,
        imageFile: MessageImageContent? = nil,
        text: MessageTextContent? = nil
    ) {
        self.type = type
        self.imageFile = imageFile
        self.text = text
    }

}
