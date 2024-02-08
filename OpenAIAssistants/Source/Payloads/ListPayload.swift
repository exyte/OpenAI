//
//  ListPayload.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct ListPayload: Codable {

    public let limit: Int?
    public let order: Order?
    public let after: String?
    public let before: String?
    
    public init(
        limit: Int? = nil,
        order: Order? = nil,
        after: String? = nil,
        before: String? = nil
    ) {
        self.limit = limit
        self.order = order
        self.after = after
        self.before = before
    }

}
