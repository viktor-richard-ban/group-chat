//
//  ChatServiceImpl.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 06. 08..
//

import Foundation
import OSLog

final class ChatServiceImpl: ChatService {
    private var webSocketTask: URLSessionWebSocketTask?
    private let stream: AsyncStream<MessageApiModel>
    private let continuation: AsyncStream<MessageApiModel>.Continuation
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "", category: "ChatService")
    
    init() {
        let stream = AsyncStream<MessageApiModel>.makeStream()
        self.stream = stream.stream
        self.continuation = stream.continuation
        connect()
        startPinging()
    }
    
    func send(message: MessageApiModel) async throws -> Bool {
        let encoder = JSONEncoder()
        let data = try encoder.encode(message)
        let result = String(decoding: data, as: UTF8.self)
        
        let messageToSend = URLSessionWebSocketTask.Message.string(result)
        return await withCheckedContinuation { continuation in
            webSocketTask?.send(messageToSend) { [logger] error in
                if let error = error {
                    logger.debug("Failed to send message: \(error)")
                    return continuation.resume(returning: false)
                } else {
                    logger.debug("Message sent: \(result)")
                    return continuation.resume(returning: true)
                }
            }
        }
    }
    
    func listen() -> AsyncStream<MessageApiModel> {
        return stream
    }
    
    private func connect() {
        let url = URLProvider.url(for: .webSocket)
        webSocketTask = URLSession(configuration: .default)
            .webSocketTask(with: url)
        webSocketTask?.resume()
        receive()
    }
    
    private func startPinging() {
        webSocketTask?.sendPing { [weak self] error in
            guard let self else { return }
            
            if let error = error {
                self.logger.log("Ping failed: \(error)")
                self.sendConnectionState(state: .disconnected)
                self.connect()
            } else {
                self.logger.log("Ping succeeded")
                self.sendConnectionState(state: .connected)
            }
            
            DispatchQueue.global().asyncAfter(deadline: .now() + 2) { [weak self] in
                self?.startPinging()
            }
        }
    }
    
    private func receive() {
        webSocketTask?.receive(completionHandler: { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let message):
                if case .string(let messageString) = message {
                    self.logger.debug("Message received - String: \(messageString)")
                    let decodedMessage = self.decodedMessage(messageString)
                    if let decodedMessage {
                        self.continuation.yield(decodedMessage)
                    }
                    self.receive()  // Continue receiving the next message
                } else {
                    self.logger.debug("Message received - Other")
                }
            case .failure(let error):
                self.logger.debug("Receiving message failed: \(error.localizedDescription)")
            }
        })
    }
    
    private func sendConnectionState(state: ConnectionStatus) {
        let message = Message(text: state.rawValue, type: .connectivity)
        continuation.yield(message)
    }
    
    private func decodedMessage(_ messageString: String) -> Message? {
        guard let data = messageString.data(using: .utf8) else {
            assertionFailure("Failed to convert string to Data")
            return nil
        }
        return apiModel
    }
}
