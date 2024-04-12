//
//  File.swift
//  
//
//  Created by vadim.vitkovskiy on 12.04.2024.
//

import Foundation

public struct FilePayload: Codable {

    public let purpose: String
    public let file: Data

    public init(
        purpose: FilePurpose,
        file: Data
    ) {
        self.purpose = FilePurpose.assistants.rawValue
        self.file = file
    }
}
