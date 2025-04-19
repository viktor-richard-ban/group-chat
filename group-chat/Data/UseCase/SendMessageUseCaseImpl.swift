//
//  SendMessageUseCaseImpl.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 19..
//

struct SendMessageUseCaseImpl: SendMessageUseCase {
    private let service: ChatService
    
    init(service: ChatService) {
        self.service = service
    }
    
    func execute(message: String) {
        service.send(message: message)
    }
}
