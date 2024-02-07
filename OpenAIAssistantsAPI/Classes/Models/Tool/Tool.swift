//
//  Tool.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct Tool: Codable {

    public let type: ToolType
    public let function: Function?
    
    public init(type: ToolType, function: Function? = nil) {
        self.type = type
        self.function = function
    }

}
