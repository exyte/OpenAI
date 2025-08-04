//
//  CreateTranscriptionPayload.swift
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

public struct CreateTranscriptionPayload: Codable {

    let file: URL
    let model: STTModel
    let language: String?
    let prompt: String?
    let responseFormat: TextResponseFormat?
    let temperature: Double?
    let timestampGranularities: [TimestampGranularity]?

    public init(
        file: URL,
        model: STTModel,
        language: String? = nil,
        prompt: String? = nil,
        responseFormat: TextResponseFormat? = nil,
        temperature: Double? = nil,
        timestampGranularities: [TimestampGranularity]? = nil
    ) {
        self.file = file
        self.model = model
        self.language = language
        self.prompt = prompt
        self.responseFormat = responseFormat
        self.timestampGranularities = timestampGranularities
        self.temperature = temperature
    }

}
