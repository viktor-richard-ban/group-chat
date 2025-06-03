//
//  SendMessageUseCaseImpl.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 19..
//

import Foundation

struct SendMessageUseCaseImpl: SendMessageUseCase {
    private let service: ChatService
    
    init(service: ChatService) {
        self.service = service
    }
    
    func execute(message: String) {
        let textMessageApiModel = TextMessageApiModel(type: .text, userId: UUID(), text: message)
        let messageApiModel = MessageApiModel.text(textMessageApiModel)
        try? service.send(message: messageApiModel)
    }
}
