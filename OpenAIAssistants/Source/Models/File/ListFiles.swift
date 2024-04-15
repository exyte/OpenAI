//
//  File 2.swift
//  
//
//  Created by vadim.vitkovskiy on 15.04.2024.
//

import Foundation

public struct ListFiles: Codable {

    public let hasMore: Bool
    public let object: String
    public let data: [File]

    enum CodingKeys: String, CodingKey {
        case hasMore = "has_more"
        case object, data
    }

}
