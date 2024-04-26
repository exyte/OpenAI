//
//  OpenAI+Files.swift
//
//  Copyright (c) 2024 Exyte
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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

    func listFiles() -> AnyPublisher<ObjectList<File>, MoyaError> {
        filesProvider.requestPublisher(.listFiles)
            .map(ObjectList<File>.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func retrieveFile(id: String) -> AnyPublisher<File, MoyaError> {
        filesProvider.requestPublisher(.retrieveFile(id: id))
            .map(File.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func deleteFile(id: String) -> AnyPublisher<DeletionStatus, MoyaError> {
        filesProvider.requestPublisher(.deleteFile(id: id))
            .map(DeletionStatus.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    /// Only files that are generated by assistants (e.g., https://platform.openai.com/docs/assistants/tools/code-interpreter) can be downloaded.
    /// You can’t download files that you’ve uploaded to the assistants yourself.
    /// If these files are important, you should consider storing a copy of these files before they’re uploaded.
    func retrieveFileContent(id: String) -> AnyPublisher<Response, MoyaError> {
        filesProvider.requestPublisher(.retrieveFileContent(id: id))
    }

}