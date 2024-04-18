//
//  FilePayload.swift
//  
//
//  Created by vadim.vitkovskiy on 12.04.2024.
//

import Foundation

public struct FilePayload: Codable {

    public let purpose: String
    public let fileURL: URL

    public init(
        purpose: FilePurpose,
        fileURL: URL
    ) {
        self.purpose = purpose.rawValue
        self.fileURL = fileURL
    }
}
