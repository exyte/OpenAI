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

    func createSpeechPayload(from payload: CreateSpeechPayload, destination: URL) -> AnyPublisher<URL, OpenAIError> {
        audioProvider.downloadTaskPublisher(for: .createSpeechPayload(payload: payload, destination: destination))
            .eraseToAnyPublisher()
    }

    func createTranscriptionPayload(from payload: CreateTranscriptionPayload) -> AnyPublisher<Transcription, OpenAIError> {
        audioProvider.requestPublisher(for: .createTranscriptionPayload(payload: payload))
            .map { $0.data }
            .map(to: Transcription.self, decoder: OpenAI.defaultDecoder)
            .eraseToAnyPublisher()
    }

    func createTranslationPayload(from payload: CreateTranslationPayload) -> AnyPublisher<Translation, OpenAIError> {
        audioProvider.requestPublisher(for: .createTranslationPayload(payload: payload))
            .map { $0.data }
            .map(to: Translation.self, decoder: OpenAI.defaultDecoder)
            .eraseToAnyPublisher()
    }

}

// MARK: - Concurrency

public extension OpenAI {

    func createSpeechPayload(from payload: CreateSpeechPayload, destination: URL) async throws -> URL {
        try await createSpeechPayload(from: payload, destination: destination).async()
    }

    func createTranscriptionPayload(from payload: CreateTranscriptionPayload) async throws -> Transcription {
        try await createTranscriptionPayload(from: payload).async()
    }

    func createTranslationPayload(from payload: CreateTranslationPayload) async throws -> Translation {
        try await createTranslationPayload(from: payload).async()
    }

}
