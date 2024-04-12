//
//  File.swift
//  
//
//  Created by vadim.vitkovskiy on 12.04.2024.
//

import Foundation
import Combine
import Moya

public extension OpenAI {

    func uploadFile(payload: FilePayload) -> AnyPublisher<File, MoyaError> {
        filesProvider.requestPublisher(.uploadFile(payload: payload))
            .map(File.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func listFiles() -> AnyPublisher<[String: [File]], MoyaError> {
         filesProvider.requestPublisher(.listFiles)
            .map([String: [File]].self)
            .eraseToAnyPublisher()
    }
}
