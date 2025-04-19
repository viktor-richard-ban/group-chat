//
//  ListenMessagesUseCaseImpl.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 19..
//

struct ListenMessagesUseCaseImpl: ListenMessagesUseCase {
    private let service: ChatService
    
    init(service: ChatService) {
        self.service = service
    }
    
    func listen() -> AsyncStream<String> {
        service.listen()
    }
}
