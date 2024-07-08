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

public extension OpenAI {

    func listModels() -> AnyPublisher<ObjectList<Model>, OpenAIError> {
        modelsProvider.requestPublisher(for: .listModels)
            .map { $0.data }
            .map(to: ObjectList<Model>.self, decoder: OpenAI.defaultDecoder)
            .eraseToAnyPublisher()
    }

    func retrieveModel(with id: String) -> AnyPublisher<Model, OpenAIError> {
        modelsProvider.requestPublisher(for: .retrieveModel(modelId: id))
            .map { $0.data }
            .map(to: Model.self, decoder: OpenAI.defaultDecoder)
            .eraseToAnyPublisher()
    }

    func deleteModel(with id: String) -> AnyPublisher<DeletionStatus, OpenAIError> {
        modelsProvider.requestPublisher(for: .deleteModel(modelId: id))
            .map { $0.data }
            .map(to: DeletionStatus.self, decoder: OpenAI.defaultDecoder)
            .eraseToAnyPublisher()
    }

}
