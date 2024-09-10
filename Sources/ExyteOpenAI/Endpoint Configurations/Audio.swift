//
//  Audio.swift
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

enum Audio {
    case createTranscription(payload: CreateTranscriptionPayload)
    case createTranslation(payload: CreateTranslationPayload)
    case createSpeech(payload: CreateSpeechPayload, destination: URL)
}

extension Audio: EndpointConfiguration {

    var method: HTTPRequestMethod {
        return .post
    }

    var path: String {
        switch self {
        case .createTranscription:
            return "/audio/transcriptions"
        case .createTranslation:
            return "/audio/translations"
        case .createSpeech:
            return "/audio/speech"
        }
    }

    var task: RequestTask {
        switch self {
        case .createTranscription(let payload):
            var data: [FormBodyPart] = [
                FormBodyPart(
                    name: "file",
                    value: .fileURL(payload.file),
                    fileName: payload.file.lastPathComponent,
                    mimeType: payload.file.pathExtension
                ),
                FormBodyPart(
                    name: "model",
                    value: .plainText(payload.model.rawValue)
                ),
                FormBodyPart(
                    name: "response_format",
                    value: .plainText(payload.responseFormat?.rawValue ?? TextResponseFormat.json.rawValue)
                )
            ]
            if let temperature = payload.temperature {
                data.append(
                    FormBodyPart(
                        name: "temperature",
                        value: .floatingPoint(Float(temperature))
                    )
                )
            }
            if let prompt = payload.prompt {
                data.append(
                    FormBodyPart(
                        name: "prompt",
                        value: .plainText(prompt)
                    )
                )
            }
            if let language = payload.language {
                data.append(
                    FormBodyPart(
                        name: "language",
                        value: .plainText(language))
                )
            }
            if let timestampGranularities = payload.timestampGranularities,
               payload.responseFormat == .verboseJson {
                let timestampGranularitiesData = withUnsafeBytes(of: timestampGranularities) { Data($0) }
                data.append(
                    FormBodyPart(
                        name: "timestamp_granularities",
                        value: .data(timestampGranularitiesData)
                    )
                )
            }
            return .uploadMultipart(data)
        case .createTranslation(let payload):
            var data: [FormBodyPart] = [
                FormBodyPart(
                    name: "file",
                    value: .fileURL(payload.file),
                    fileName: payload.file.lastPathComponent,
                    mimeType: payload.file.pathExtension
                ),
                FormBodyPart(
                    name: "model",
                    value: .plainText(payload.model.rawValue)
                ),
                FormBodyPart(
                    name: "response_format",
                    value: .plainText(payload.responseFormat?.rawValue ?? TextResponseFormat.json.rawValue)
                )
            ]
            if let prompt = payload.prompt {
                data.append(
                    FormBodyPart(
                        name: "prompt",
                        value: .plainText(prompt)
                    )
                )
            }
            if let temperature = payload.temperature {
                data.append(
                    FormBodyPart(
                        name: "temperature",
                        value: .floatingPoint(Float(temperature))
                    )
                )
            }
            return .uploadMultipart(data)
        case .createSpeech(let payload, let destination):
            return .download(payload, destination)
        }
    }

}
