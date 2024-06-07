//
//  StreamEventError.swift
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

public enum StreamEvent {

    case unknown
    case threadRunCreated(Run)
    case threadRunQueued(Run)
    case threadRunInProgress(Run)
    case threadRunStepCreated(RunStep)
    case threadRunStepInProgress(RunStep)
    case threadMessageCreated(Message)
    case threadMessageInProgress(Message)
    case threadMessageDelta(DeltaMessage)
    case threadMessageCompleted(Message)
    case threadRunStepCompleted(RunStep)
    case threadRunCompleted(Run)
    case done

    var eventName: String {
        switch self {
        case .threadRunCreated:
            return "thread.run.created"
        case .threadRunQueued:
            return "thread.run.queued"
        case .threadRunInProgress:
            return "thread.run.in_progress"
        case .threadRunStepCreated:
            return "thread.run.step.created"
        case .threadMessageCreated:
            return "thread.message.created"
        case .threadMessageDelta:
            return "thread.message.delta"
        case .unknown:
            return "unknown"
        case .threadRunStepInProgress:
            return "thread.run.step.in_progress"
        case .threadMessageInProgress:
            return "thread.message.in_progress"
        case .threadMessageCompleted:
            return "thread.message.completed"
        case .threadRunStepCompleted:
            return "thread.run.step.completed"
        case .threadRunCompleted:
            return "thread.run.completed"
        case .done:
            return "done"
        }
    }

    public init?(eventName: String, data: Data) throws {
        self = .unknown
        switch eventName {
        case "thread.run.created",
            "thread.run.queued",
            "thread.run.in_progress",
            "thread.run.completed":
            let model: Run? = StreamEvent.decodeData(data)
            guard let model else {
                throw StreamError.decodeError
            }

            if eventName == "thread.run.created" {
                self = .threadRunCreated(model)
            } else if eventName == "thread.run.in_progress" {
                self = .threadRunInProgress(model)
            } else if eventName == "thread.run.queued" {
                self = .threadRunQueued(model)
            } else if eventName == "thread.run.completed" {
                self = .threadRunCompleted(model)
            }
        case "thread.run.step.created",
            "thread.run.step.in_progress",
            "thread.run.step.completed":
            let model: RunStep? = StreamEvent.decodeData(data)
            guard let model else {
                throw StreamError.decodeError
            }

            if eventName == "thread.run.step.created" {
                self = .threadRunStepCreated(model)
            } else if eventName == "thread.run.step.in_progress" {
                self = .threadRunStepInProgress(model)
            } else if eventName == "thread.run.step.completed" {
                self = .threadRunStepCompleted(model)
            }
        case "thread.message.created",
            "thread.message.in_progress",
            "thread.message.completed":
            let model: Message? = StreamEvent.decodeData(data)
            guard let model else {
                throw StreamError.decodeError
            }

            if eventName == "thread.message.created" {
                self = .threadMessageCreated(model)
            } else if eventName == "thread.message.in_progress" {
                self = .threadMessageInProgress(model)
            } else if eventName == "thread.message.completed" {
                self = .threadMessageCompleted(model)
            }
        case "thread.message.delta":
            let model: DeltaMessage? = StreamEvent.decodeData(data)
            guard let model else {
                throw StreamError.decodeError
            }

            self = .threadMessageDelta(model)
        case "done":
            self = .done
        default:
            throw StreamError.unknownEvent
        }
    }

    static private func decodeData<T: Decodable>(_ data: Data) -> T? {
        guard let model = try? OpenAI.defaultDecoder.decode(T.self, from: data) else {
            return nil
        }

        return model
    }

}
