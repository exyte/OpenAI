//
//  OpenAI+Models.swift
//
//  Copyright © 2020-2024 by Voicely Social Inc. All rights reserved.
//  Voicely® and related marks and logos are trademarks and/or registered trademarks of Voicely Social Inc. and its affiliates.
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
