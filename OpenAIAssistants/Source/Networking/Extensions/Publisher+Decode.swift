//
//  Publisher+Decode.swift
//  OpenAIAssistants
//
//  Created by Dmitry Shipinev on 05.07.2024.
//

import Combine

extension Publisher {
    func map<Item, Coder>(to type: Item.Type, decoder: Coder) -> Publishers.FlatMap<Publishers.MapError<Publishers.Decode<Just<Self.Output>, Item, Coder>, OpenAIError>, Self> where Item : Decodable, Coder : TopLevelDecoder, Self.Output == Coder.Input {
        return flatMap {
            Just($0)
                .decode(type: type, decoder: decoder)
                .mapError { error -> OpenAIError in
                    switch error {
                    case let apiError as OpenAIError:
                        return apiError
                    default:
                        return OpenAIError.decodingFailed(underlyingError: error)
                    }
                }
        }
    }
}
