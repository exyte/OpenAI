//
//  AIManager.swift
//  OpenAIAssistantsExample
//
//  Created by Alisa Mylnikova on 25.06.2024.
//

import Foundation
import Combine
import ExyteOpenAI

final class AIManager {
    private let apiKey: String = ""
    private let assistantId: String = ""

    private let client: OpenAI
    private var threadId = ""
    private var didReceiveResponse: ((String, String)->())?

    private var subscriptions = Set<AnyCancellable>()

    init() {
        guard !apiKey.isEmpty else {
            fatalError("Empty OpenAI API key")
        }
        guard !assistantId.isEmpty else {
            fatalError("Empty Assistant ID")
        }
        client = OpenAI(apiKey: apiKey)
        createThreadIfNeeded()
    }

    func getBotResponse(_ messageText: String) async -> (String, String) { // id, text
        await withCheckedContinuation { continuation in
            didReceiveResponse = { id, text in
                continuation.resume(returning: (id, text))
                self.didReceiveResponse = nil
            }
            sendMessage(messageText, fileID: nil)
        }
    }
}

private extension AIManager {
    func createThreadIfNeeded() {
        guard let threadId = UserDefaults.standard.value(forKey: "thread_id") as? String else {
            createThread()
            return
        }
        self.threadId = threadId
    }

    func createThread() {
        let createThreadPayload = CreateThreadPayload(
            messages: [],
            metadata: [:]
        )
        client.createThread(from: createThreadPayload)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .failure(let error):
                        debugPrint(error)
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] thread in
                    self?.threadId = thread.id
                    UserDefaults.standard.setValue(thread.id, forKey: "thread_id")
                }
            )
            .store(in: &subscriptions)
    }

    func sendMessage(_ messageText: String, fileID: String?) {
        let createMessagePayload = CreateMessagePayload(role: .user, content: messageText)
        client.createMessage(in: threadId, payload: createMessagePayload)
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .failure(let error):
                        debugPrint(error)
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] message in
                    self?.createRun(lastMessageId: message.id)
                }
            )
            .store(in: &subscriptions)
    }

    func sendMessage(_ messageText: String, fileURL: URL) {
        let filePayload = FilePayload(purpose: .assistants, fileURL: fileURL)
        client.uploadFile(payload: filePayload)
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .failure(let error):
                        debugPrint(error)
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] file in
                    self?.sendMessage(messageText, fileID: file.id)
                }
            )
            .store(in: &subscriptions)
    }

    func createRun(lastMessageId: String) {
        let runPayload = CreateRunPayload(assistantId: assistantId)
        client.createRun(in: threadId, payload: runPayload)
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .failure(let error):
                        debugPrint(error)
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] run in
                    self?.checkRunStatus(runId: run.id, lastMessageId: lastMessageId)
                }
            )
            .store(in: &subscriptions)
    }

    func checkRunStatus(runId: String, lastMessageId: String) {
        client.retrieveRun(id: runId, from: threadId)
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .failure(let error):
                        debugPrint(error)
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] run in
                    if run.status != .completed {
                        usleep(300)
                        self?.checkRunStatus(runId: runId, lastMessageId: lastMessageId)
                    } else {
                        self?.fetchResponse(lastMessageId: lastMessageId)
                    }
                }
            )
            .store(in: &subscriptions)
    }

    func fetchResponse(lastMessageId: String) {
        let listPayload = ListPayload(limit: 1, order: .asc, after: lastMessageId)
        client.listMessages(from: threadId, payload: listPayload)
            .sink(
                receiveCompletion: { result in
                    switch result {
                    case .failure(let error):
                        debugPrint(error)
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] list in
                    guard let message = list.data.first,
                          let textContent = message.content.first?.text?.value else { return }
                    self?.didReceiveResponse?(message.id, textContent)
                }
            )
            .store(in: &subscriptions)
    }
}
