//
//  ModelType.swift
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

public enum ModelType: String, Codable {

    // GPT-4
    case gpt_4o = "gpt-4o"
    case gpt_4o_2024_05_13 = "gpt-4o-2024-05-13"
    case gpt_4_turbo = "gpt-4-turbo"
    case gpt_4_turbo_2024_04_09 = "gpt-4-turbo-2024-04-09"
    case gpt_4_0125_preview = "gpt-4-0125-preview"
    case gpt_4_turbo_preview = "gpt-4-turbo-preview"
    case gpt_4_1106_preview = "gpt-4-1106-preview"
    case gpt_4_vision_preview = "gpt-4-vision-preview"
    case gpt_4 = "gpt-4"
    case gpt_4_0314 = "gpt-4-0314"
    case gpt_4_0613 = "gpt-4-0613"
    case gpt_4_32k = "gpt-4-32k"
    case gpt_4_32k_0314 = "gpt-4-32k-0314"
    case gpt_4_32k_0613 = "gpt-4-32k-0613"
    
    // GPT-3.5
    case gpt_3_5_turbo = "gpt-3.5-turbo"
    case gpt_3_5_turbo_16k = "gpt-3.5-turbo-16k"
    case gpt_3_5_turbo_0301 = "gpt-3.5-turbo-0301"
    case gpt_3_5_turbo_0613 = "gpt-3.5-turbo-0613"
    case gpt_3_5_turbo_1106 = "gpt-3.5-turbo-1106"
    case gpt_3_5_turbo_0125 = "gpt-3.5-turbo-0125"
    case gpt_3_5_turbo_16k_0613 = "gpt-3.5-turbo-16k-0613"
    
    case unknown = "unknown"

    public init(from decoder: Decoder) {
        do {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(String.self)
            self = ModelType(rawValue: rawValue) ?? .unknown
        } catch {
            self = .unknown
        }
    }

}
