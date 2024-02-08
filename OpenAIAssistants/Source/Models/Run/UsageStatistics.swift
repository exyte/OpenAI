//
//  UsageStatistics.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public struct UsageStatistics: Codable {

    let completionTokens: Int
    let promptTokens: Int
    let totalTokens: Int

}
