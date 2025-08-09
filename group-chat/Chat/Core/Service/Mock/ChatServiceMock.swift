//
//  ChatServiceMock.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 19..
//

import Foundation

struct ChatServiceMock: ChatService {
    var delegate: ChatServiceDelegate?
    
    private let stream: AsyncStream<MessageApiModel>
    private let continuation: AsyncStream<MessageApiModel>.Continuation
    
    init() {
        let stream = AsyncStream<MessageApiModel>.makeStream()
        self.stream = stream.stream
        self.continuation = stream.continuation
    }
    
    func send(message: MessageApiModel) async throws -> Bool {
        continuation.yield(message)
        return true
    }
    
    
    func listen() -> AsyncStream<MessageApiModel> {
        stream
    }
}
