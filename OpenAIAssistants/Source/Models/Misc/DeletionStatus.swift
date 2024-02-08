//
//  DeletionStatus.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct DeletionStatus: Codable {

    public let id: String
    public let object: String
    public let deleted: Bool
    
    public init(id: String, object: String, deleted: Bool) {
        self.id = id
        self.object = object
        self.deleted = deleted
    }

}
