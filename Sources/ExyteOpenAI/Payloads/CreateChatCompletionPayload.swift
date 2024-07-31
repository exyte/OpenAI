//
//  CreateChatCompletionPayload.swift
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

public struct CreateChatCompletionPayload: Codable {

    public let model: ModelType
    public let messages: [ChatCompletionMessage]
    public let frequencyPenalty: Double?
    public let logitBias: [String: String]?
    public let logprobs: Bool?
    public let topLogprobs: Int?
    public let maxTokens: Int?
    public let n: Int?
    public let presencePenalty: Double?
    public let responseFormat: ResponseFormat?
    public let seed: Int?
    public let stop: String?
    public let stream: Bool?
    public let streamOptions: StreamOptions?
    public let temperature: Double?
    public let topP: Double?
    public let tools: [Tool]?
    public let toolChoice: Tool?
    public let parallelToolCalls: Bool?
    public let user: String?
    
    public init(
        model: ModelType,
        messages: [ChatCompletionMessage],
        frequencyPenalty: Double? = nil,
        logitBias: [String: String]? = nil,
        logprobs: Bool? = nil,
        topLogprobs: Int? = nil,
        maxTokens: Int? = nil,
        n: Int? = nil,
        presencePenalty: Double? = nil,
        responseFormat: ResponseFormat? = nil,
        seed: Int? = nil,
        stop: String? = nil,
        stream: Bool? = nil,
        streamOptions: StreamOptions? = nil,
        temperature: Double? = nil,
        topP: Double? = nil,
        tools: [Tool]? = nil,
        toolChoice: Tool? = nil,
        parallelToolCalls: Bool? = nil,
        user: String? = nil
        
    ) {
        self.model = model
        self.messages = messages
        self.frequencyPenalty = frequencyPenalty
        self.logitBias = logitBias
        self.logprobs = logprobs
        self.topLogprobs = topLogprobs
        self.maxTokens = maxTokens
        self.n = n
        self.presencePenalty = presencePenalty
        self.responseFormat = responseFormat
        self.seed = seed
        self.stop = stop
        self.stream = stream
        self.streamOptions = streamOptions
        self.temperature = temperature
        self.topP = topP
        self.tools = tools
        self.toolChoice = toolChoice
        self.parallelToolCalls = parallelToolCalls
        self.user = user
    }
    
}
