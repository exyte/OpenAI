//
//  File.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct File: Codable {

    public let id: String
    public let bytes: Int
    public let createdAt: Date
    public let filename: String
    public let object: String
    public let purpose: FilePurpose
    
    public init(
        id: String,
        bytes: Int,
        createdAt: Date,
        filename: String,
        object: String,
        purpose: FilePurpose
    ) {
        self.id = id
        self.bytes = bytes
        self.createdAt = createdAt
        self.filename = filename
        self.object = object
        self.purpose = purpose
    }

}
