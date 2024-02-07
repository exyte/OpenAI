//
//  OpenAIError.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct RunError: Codable {

    public let code: RunErrorCode
    public let message: String

    public init(code: RunErrorCode, message: String) {
        self.code = code
        self.message = message
    }

}
