//
//  RunStatus.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public enum RunStatus: String, Codable {

    case queued = "queued"
    case inProgress = "in_progress"
    case requiresAction = "requires_action"
    case cancelling = "cancelling"
    case cancelled = "cancelled"
    case failed = "failed"
    case completed = "completed"
    case expired = "expired"

}
