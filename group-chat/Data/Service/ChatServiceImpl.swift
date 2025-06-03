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
    private let stream: AsyncStream<Message>
    private let continuation: AsyncStream<Message>.Continuation
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "", category: "ChatService")
    
    init() {
        let stream = AsyncStream<Message>.makeStream()
        self.stream = stream.stream
        self.continuation = stream.continuation
        connect()
        receive()
    }
    
    func send(message: MessageApiModel) throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(message)
        let result = String(decoding: data, as: UTF8.self)
        
        let messageToSend = URLSessionWebSocketTask.Message.string(result)
        webSocketTask?.send(messageToSend) { [logger] error in
            if let error = error {
                logger.debug("Failed to send message: \(error)")
            } else {
                logger.debug("Message sent: \(result)")
            }
        }
    }
    
    func listen() -> AsyncStream<Message> {
        return stream
    }
    
    private func connect() {
        guard let url = URL(string: Constants.webSocketEchoURLString) else {
            assertionFailure("Url string must be a valid url")
            return
        }
        webSocketTask = URLSession(configuration: .default)
            .webSocketTask(with: url)
        webSocketTask?.resume()
        logger.debug("Connection created to the server")
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
    
    private func decodedMessage(_ messageString: String) -> Message? {
        guard let data = messageString.data(using: .utf8) else {
            assertionFailure("Failed to convert string to Data")
            return nil
        }
        do {
            let decoder = JSONDecoder()
            let apiModel = try decoder.decode(MessageApiModel.self, from: data)
            switch apiModel {
            case .text(let textMessageApiModel):
                let message = Message(text: textMessageApiModel.text, type: .received)
                return message
            }
        } catch {
            logger.error("Failed to decode Message: \(error.localizedDescription)")
        }
        
        return nil
    }
}

private extension ChatServiceImpl {
    enum Constants {
        static let webSocketEchoURLString = "wss://echo.websocket.events"
        static let webSocketURLString = "ws://localhost/ws"
    }
}
