//
//  ChatServiceMock.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 19..
//

import Foundation
import Combine

final class ChatServiceMock: ChatService {
    var delegate: ChatServiceDelegate?
    var messageStream: AnyPublisher<MessageApiModel, Never> {
        messageSubject.eraseToAnyPublisher()
    }
    private let messageSubject = PassthroughSubject<MessageApiModel, Never>()
    
    var sentMessages: [MessageApiModel] = []
    func send(message: MessageApiModel) {
        sentMessages.append(message)
    }
    
    func receiveMessage(_ message: MessageApiModel) {
        messageSubject.send(message)
    }
}
