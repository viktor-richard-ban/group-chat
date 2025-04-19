//
//  ChatService.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 19..
//

import Foundation
import OSLog

protocol ChatService {
    func send(message: String)
    func listen() -> AsyncStream<String>
}

struct ChatServiceImpl: ChatService {
    private var webSocketTask: URLSessionWebSocketTask?
    private let stream: AsyncStream<String>
    private let continuation: AsyncStream<String>.Continuation
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "", category: "ChatService")
    
    init() {
        let stream = AsyncStream<String>.makeStream()
        self.stream = stream.stream
        self.continuation = stream.continuation
        connect()
        receive()
    }
    
    func send(message: String) {
        let messageToSend = URLSessionWebSocketTask.Message.string(message)
        webSocketTask?.send(messageToSend) { error in
            if let error = error {
                logger.debug("Failed to send message: \(error)")
            } else {
                logger.debug("Message sent: \(message)")
            }
        }
    }
    
    func listen() -> AsyncStream<String> {
        return stream
    }
    
    private mutating func connect() {
        let url = URL(string: "wss://echo.websocket.events")!
        self.webSocketTask = URLSession(configuration: .default)
            .webSocketTask(with: url)
        webSocketTask?.resume()
        logger.debug("Connection created to the server")
    }
    
    private func receive() {
        webSocketTask?.receive(completionHandler: { result in
            switch result {
            case .success(let message):
                if case .string(let messageString) = message {
                    logger.debug("Message received - String: \(messageString)")
                    self.continuation.yield(messageString)
                    self.receive()  // Continue receiving the next message
                } else {
                    logger.debug("Message received - Other")
                }
            case .failure(let error):
                logger.debug("Receiving message failed: \(error.localizedDescription)")
            }
        })
    }
}
