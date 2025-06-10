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

    // O-series
    case o1 = "o1"
    case o1_2024_12_17 = "o1-2024-12-17"
    case o1_preview = "o1-preview"
    case o1_preview_2024_09_12 = "o1-preview-2024-09-12"
    case o1_mini = "o1-mini"
    case o1_mini_2024_09_12 = "o1-mini-2024-09-12"
    case o1_pro = "o1-pro"
    case o1_pro_2025_03_19 = "o1-pro-2025-03-19"
    
    case o3 = "o3"
    case o3_2025_04_16 = "o3-2025-04-16"
    case o3_mini = "o3-mini"
    case o3_mini_2025_01_31 = "o3-mini-2025-01-31"
    
    case o4_mini = "o4-mini"
    case o4_mini_2025_04_16 = "o4-mini-2025-04-16"
    
    // Computer Use
    case computer_use_preview = "computer-use-preview"
    case computer_use_preview_2025_03_11 = "computer-use-preview-2025-03-11"

    // GPT-4.1
    case gpt_4_1 = "gpt-4.1"
    case gpt_4_1_mini = "gpt-4.1-mini"
    case gpt_4_1_nano = "gpt-4.1-nano"
    case gpt_4_1_2025_04_14 = "gpt-4.1-2025-04-14"
    case gpt_4_1_mini_2025_04_14 = "gpt-4.1-mini-2025-04-14"
    case gpt_4_1_nano_2025_04_14 = "gpt-4.1-nano-2025-04-14"
    
    // GPT-4o & variants
    case gpt_4o = "gpt-4o"
    case gpt_4o_2024_11_20 = "gpt-4o-2024-11-20"
    case gpt_4o_2024_08_06 = "gpt-4o-2024-08-06"
    case gpt_4o_2024_05_13 = "gpt-4o-2024-05-13"
    case gpt_4o_audio_preview = "gpt-4o-audio-preview"
    case gpt_4o_audio_preview_2024_10_01 = "gpt-4o-audio-preview-2024-10-01"
    case gpt_4o_audio_preview_2024_12_17 = "gpt-4o-audio-preview-2024-12-17"
    case gpt_4o_mini_audio_preview = "gpt-4o-mini-audio-preview"
    case gpt_4o_mini_audio_preview_2024_12_17 = "gpt-4o-mini-audio-preview-2024-12-17"
    case gpt_4o_search_preview = "gpt-4o-search-preview"
    case gpt_4o_search_preview_2025_03_11 = "gpt-4o-search-preview-2025-03-11"
    case gpt_4o_mini_search_preview = "gpt-4o-mini-search-preview"
    case gpt_4o_mini_search_preview_2025_03_11 = "gpt-4o-mini-search-preview-2025-03-11"
    case chatgpt_4o_latest = "chatgpt-4o-latest"
    case gpt_4o_mini = "gpt-4o-mini"
    case gpt_4o_mini_2024_07_18 = "gpt-4o-mini-2024-07-18"

    // GPT-4 Turbo and previews
    case gpt_4_turbo = "gpt-4-turbo"
    case gpt_4_turbo_2024_04_09 = "gpt-4-turbo-2024-04-09"
    case gpt_4_0125_preview = "gpt-4-0125-preview"
    case gpt_4_turbo_preview = "gpt-4-turbo-preview"
    case gpt_4_1106_preview = "gpt-4-1106-preview"
    case gpt_4_vision_preview = "gpt-4-vision-preview"
    
    // GPT-4 classic and 32k
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
