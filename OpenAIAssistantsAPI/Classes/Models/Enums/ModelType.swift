//
//  ModelType.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public enum ModelType: String, Codable {

    case gpt3_5 = "gpt-3.5"
    case gpt3_5_turbo = "gpt-3.5-turbo"
    case gpt4 = "gpt-4"
    case gpt4_5_turbo = "gpt-4-turbo-preview"

}
