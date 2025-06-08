//
//  SendMessageUseCaseImpl.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 19..
//

import Foundation

struct SendMessageUseCaseImpl: SendMessageUseCase {
    private let service: ChatService
    private let store: ChatStore
    
    init(service: ChatService,
         store: ChatStore) {
        self.service = service
        self.store = store
    }
    
    func send(message: String) {
        let textMessageApiModel = TextMessageApiModel(type: .text, userId: UUID(), text: message)
        let messageApiModel = MessageApiModel.text(textMessageApiModel)
        Task {
            let result = try? await service.send(message: messageApiModel)
            if result == true {
                let sentMessage = Message(text: message, type: .sent)
                store.reduce(.show(sentMessage))
            }
        }
    }
}
