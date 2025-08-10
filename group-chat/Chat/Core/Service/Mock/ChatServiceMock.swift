//
//  ChatServiceMock.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 19..
//

import Foundation

final class ChatServiceMock: ChatService {
    var delegate: ChatServiceDelegate?
    
    private let stream: AsyncStream<MessageApiModel>
    private let continuation: AsyncStream<MessageApiModel>.Continuation
    
    init() {
        let stream = AsyncStream<MessageApiModel>.makeStream()
        self.stream = stream.stream
        self.continuation = stream.continuation
    }
    
    var sentMessages: [MessageApiModel] = []
    func send(message: MessageApiModel) {
        sentMessages.append(message)
        continuation.yield(message)
    }
    
    
    func listen() -> AsyncStream<MessageApiModel> {
        stream
    }
}
