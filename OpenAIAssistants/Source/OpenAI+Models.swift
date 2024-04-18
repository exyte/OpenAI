//
//  OpenAI+Models.swift
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

    func listModels() -> AnyPublisher<ObjectList<Model>, MoyaError> {
        modelsProvider.requestPublisher(.listModels)
            .map(ObjectList<Model>.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func retrieveModel(with id: String) -> AnyPublisher<Model, MoyaError> {
        modelsProvider.requestPublisher(.retrieveModel(modelId: id))
            .map(Model.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

    func deleteModel(with id: String) -> AnyPublisher<DeletionStatus, MoyaError> {
        modelsProvider.requestPublisher(.deleteModel(modelId: id))
            .map(DeletionStatus.self, using: defaultDecoder)
            .eraseToAnyPublisher()
    }

}
