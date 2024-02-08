//
//  CreateMessagePayload.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct CreateMessagePayload: Codable {

    public let role: MessageRole
    public let content: String
    public let fileIds: [String]?
    public let metadata: [String: String]?
    
    public init(
        role: MessageRole,
        content: String,
        fileIds: [String]? = nil,
        metadata: [String : String]? = nil
    ) {
        self.role = role
        self.content = content
        self.fileIds = fileIds
        self.metadata = metadata
    }

}
