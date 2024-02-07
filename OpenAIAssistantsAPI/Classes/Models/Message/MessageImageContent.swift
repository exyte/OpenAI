//
//  MessageImageContent.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct MessageImageContent: Codable {

    public let fileId: String

    public init(fileId: String) {
        self.fileId = fileId
    }
    
}
