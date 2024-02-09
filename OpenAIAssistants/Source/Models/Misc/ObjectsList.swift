//
//  ObjectsList.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct ObjectList<T: Codable>: Codable {

    public let object: String
    public let data: [T]
    public let firstId: String?
    public let lastId: String?
    public let hasMore: Bool?
    
    public init(
        object: String,
        data: [T],
        firstId: String?,
        lastId: String?,
        hasMore: Bool?
    ) {
        self.object = object
        self.data = data
        self.firstId = firstId
        self.lastId = lastId
        self.hasMore = hasMore
    }

}
