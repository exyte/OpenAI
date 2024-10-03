//
//  OpenAI+Audio.swift
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

// MARK: - Combine

public extension OpenAI {

    func createSpeech(from payload: CreateSpeechPayload, destination: URL) -> AnyPublisher<URL, OpenAIError> {
        audioProvider.downloadPublisher(for: .createSpeech(payload: payload, destination: destination))
            .eraseToAnyPublisher()
    }

    func createTranscription(from payload: CreateTranscriptionPayload) -> AnyPublisher<Transcription, OpenAIError> {
        audioProvider.requestPublisher(for: .createTranscription(payload: payload))
            .map { $0.data }
            .map(to: Transcription.self, decoder: OpenAI.defaultDecoder)
            .eraseToAnyPublisher()
    }

    func createTranscription(from payload: CreateTranscriptionPayload) -> AnyPublisher<String, OpenAIError> {
        audioProvider.requestPublisher(for: .createTranscription(payload: payload))
            .flatMap {
                guard let stringData = String(data: $0.data, encoding: .utf8) else {
                    return Fail<String, OpenAIError>(error: .requestCreationFailed)
                        .eraseToAnyPublisher()
                }
                return Just<String>(stringData)
                    .setFailureType(to: OpenAIError.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    func createTranslation(from payload: CreateTranslationPayload) -> AnyPublisher<Translation, OpenAIError> {
        audioProvider.requestPublisher(for: .createTranslation(payload: payload))
            .map { $0.data }
            .map(to: Translation.self, decoder: OpenAI.defaultDecoder)
            .eraseToAnyPublisher()
    }

    func createTranslation(from payload: CreateTranslationPayload) -> AnyPublisher<String, OpenAIError> {
        audioProvider.requestPublisher(for: .createTranslation(payload: payload))
            .flatMap {
                guard let stringData = String(data: $0.data, encoding: .utf8) else {
                    return Fail<String, OpenAIError>(error: .requestCreationFailed)
                        .eraseToAnyPublisher()
                }
                return Just<String>(stringData)
                    .setFailureType(to: OpenAIError.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

}

// MARK: - Concurrency

public extension OpenAI {

    func createSpeech(from payload: CreateSpeechPayload, destination: URL) async throws -> URL {
        try await createSpeech(from: payload, destination: destination).async()
    }

    func createTranscription(from payload: CreateTranscriptionPayload) async throws -> Transcription {
        try await createTranscription(from: payload).async()
    }

    func createTranscription(from payload: CreateTranscriptionPayload) async throws -> String {
        try await createTranscription(from: payload).async()
    }

    func createTranslation(from payload: CreateTranslationPayload) async throws -> Translation {
        try await createTranslation(from: payload).async()
    }

    func createTranslation(from payload: CreateTranslationPayload) async throws -> String {
        try await createTranslation(from: payload).async()
    }

}
