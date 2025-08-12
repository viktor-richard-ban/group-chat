//
//  ChatServiceImpl.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 06. 08..
//

import Combine
import Foundation
import OSLog

protocol ChatServiceDelegate {
    func didConnectionStatusChange(_ status: ConnectionStatus)
}

final class ChatServiceImpl: ChatService {
    var delegate: ChatServiceDelegate?
    var messageStream: AnyPublisher<MessageApiModel, Never> {
        messageSubject.eraseToAnyPublisher()
    }
    
    private let messageSubject = PassthroughSubject<MessageApiModel, Never>()
    private var webSocketTask: URLSessionWebSocketTask?
    private let logger = Logger(subsystem: "ChatCore", category: "ChatService")
    
    init() {
        connect()
        startPinging()
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
                self.sendConnectionState(status: .disconnected)
                self.connect()
            } else {
                self.logger.log("Ping succeeded")
                self.sendConnectionState(status: .connected)
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
                    self.logger.debug("Message received - Type: string: \(messageString)")
                    let decodedMessage = self.decodedMessage(messageString)
                    if let decodedMessage {
                        self.messageSubject.send(decodedMessage)
                    }
                    self.receive()  // Continue receiving the next message
                } else {
                    self.logger.debug("Message received - Type: other")
                }
            case .failure(let error):
                self.logger.debug("Receiving message failed: \(error.localizedDescription)")
            }
        })
    }
    
    private func sendConnectionState(status: ConnectionStatus) {
        delegate?.didConnectionStatusChange(status)
    }
    
    private func decodedMessage(_ messageString: String) -> MessageApiModel? {
        guard let data = messageString.data(using: .utf8) else {
            assertionFailure("Failed to convert string to Data")
            return nil
        }
        do {
            let decoder = JSONDecoder()
            let apiModel = try decoder.decode(MessageApiModel.self, from: data)
            return apiModel
        } catch {
            logger.error("Failed to decode Message: \(error.localizedDescription)")
        }
        return nil
    }
}
