//
//  AssistantFile.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct AssistantFile: Codable {

    public let id: String
    public let object: String
    public let createdAt: Date
    public let assistantId: String
    
    public init(id: String, object: String, createdAt: Date, assistantId: String) {
        self.id = id
        self.object = object
        self.createdAt = createdAt
        self.assistantId = assistantId
    }

}
