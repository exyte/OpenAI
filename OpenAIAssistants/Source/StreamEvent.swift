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

public enum StreamEventError: Error {
    case decodeError
}

extension Data {
    var prettyJSON: NSString { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return "" }

        return prettyPrintedString
    }
}

public enum StreamEvent {

    case threadRunCreated(Run)
    case threadRunQueued(Run)
    case threadRunInProgress(Run)
    case threadRunStepCreated(StreamThreadRunStep)
    case threadRunStepInProgress(Run)
    case threadMessageCreated(Message)
    case threadMessageDelta(DeltaMessage)
    case error(StreamEventError)
    case unknown

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
        case .error(let error):
            return error.localizedDescription
        }
    }

    public init?(eventName: String, data: Data) {
        self = .unknown
        
        switch eventName {
        case "thread.run.created",
            "thread.run.queued",
            "thread.run.in_progress",
            "thread.run.step.in_progress":
            let model: Run? = StreamEvent.decodeData(data)
            guard let model else {
                self = .error(.decodeError)
                return
            }

            switch eventName {
            case "thread.run.created":
                self = .threadRunCreated(model)
            case "thread.run.queued":
                self = .threadRunQueued(model)
            case "thread.run.in_progress":
                self = .threadRunInProgress(model)
            case "thread.run.step.in_progress":
                self = .threadRunStepInProgress(model)
            default:
                print("unknown")
            }
        case "thread.run.step.created":
            let model: StreamThreadRunStep? = StreamEvent.decodeData(data)
            guard let model else {
                self = .error(.decodeError)
                return
            }
            
            self = .threadRunStepCreated(model)
        case "thread.message.created",
            "thread.message.delta":
            self = .error(.decodeError)
        default:
            return nil
        }
    }

    static private func decodeData<T: Decodable>(_ data: Data) -> T? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let model = try? decoder.decode(T.self, from: data) else {
            return nil
        }

        return model
    }

}
