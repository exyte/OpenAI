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
            .map(File.self)
            .eraseToAnyPublisher()
    }

    func listFiles() -> AnyPublisher<ListFiles, MoyaError> {
        filesProvider.requestPublisher(.listFiles)
            .map(ListFiles.self)
            .eraseToAnyPublisher()
    }

    func retrieveFile(id: String) -> AnyPublisher<File, MoyaError> {
        filesProvider.requestPublisher(.retrieveFile(id: id))
            .map(File.self)
            .eraseToAnyPublisher()
    }

    func deleteFile(id: String) -> AnyPublisher<DeletedFile, MoyaError> {
        filesProvider.requestPublisher(.deleteFile(id: id))
            .map(DeletedFile.self)
            .eraseToAnyPublisher()
    }

    /// Only files that are generated by assistants (e.g., https://platform.openai.com/docs/assistants/tools/code-interpreter) can be downloaded.
    /// You can’t download files that you’ve uploaded to the assistants yourself.
    /// If these files are important, you should consider storing a copy of these files before they’re uploaded.
    func retrieveFileContent(id: String) -> AnyPublisher<Response, MoyaError> {
        filesProvider.requestPublisher(.retrieveFileContent(id: id))
    }

}
