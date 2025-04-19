//
//  ChatServiceMock.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 19..
//

struct ChatServiceMock: ChatService {
    private let stream: AsyncStream<String>
    private let continuation: AsyncStream<String>.Continuation
    
    init() {
        let stream = AsyncStream<String>.makeStream()
        self.stream = stream.stream
        self.continuation = stream.continuation
    }
    
    func send(message: String) {
        continuation.yield(message)
    }
    
    func listen() -> AsyncStream<String> {
        stream
    }
}
