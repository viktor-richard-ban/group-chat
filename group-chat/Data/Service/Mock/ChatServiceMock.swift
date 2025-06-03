//
//  ChatServiceMock.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 19..
//

import Foundation

struct ChatServiceMock: ChatService {
    private let stream: AsyncStream<Message>
    private let continuation: AsyncStream<Message>.Continuation
    
    init() {
        let stream = AsyncStream<Message>.makeStream()
        self.stream = stream.stream
        self.continuation = stream.continuation
    }
    
    func send(message: MessageApiModel) throws {
        switch message {
        case .text(let textMessageApiModel):
            let textMessage = Message.init(text: textMessageApiModel.text, type: .received)
            continuation.yield(textMessage)
        }
    }
    
    func listen() -> AsyncStream<Message> {
        stream
    }
}
