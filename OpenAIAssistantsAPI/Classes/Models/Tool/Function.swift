//
//  Function.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct Function: Codable {

    public let description: String
    public let name: String
    public let parameters: String
    
    public init(description: String, name: String, parameters: String) {
        self.description = description
        self.name = name
        self.parameters = parameters
    }

}
