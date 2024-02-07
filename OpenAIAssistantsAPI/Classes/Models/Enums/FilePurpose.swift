//
//  FilePurpose.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
//

import Foundation

public enum FilePurpose: String, Codable {

    case fintTune = "fine-tune"
    case fineTuneResults = "fine-tune-results"
    case assistants = "assistants"
    case assistantsOutput = "assistants_output"

}
