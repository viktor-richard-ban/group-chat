//
//  WebSocketMiddleware.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 08. 09..
//

import Foundation

final class WebSocketMiddleware: Middleware {
    private var store: ChatStore?
    private var chatService: ChatService
    
    init(chatService: ChatService) {
        self.chatService = chatService
        self.chatService.delegate = self
        Task {
            await listen()
        }
    }
    
    func attach(store: any Store) {
        guard let store = store as? ChatStore else { return }
        self.store = store
    }
    
    func handle(action: Action) {
        guard let action = action as? ChatAction else { return }
        if case .send(let message) = action {
            let apiModel = createApiModel(message: message)
            Task {
                try await chatService.send(message: apiModel)
            }
        }
    }
    
    private func listen() async {
        for await apiModel in chatService.listen() {
            let message = Message(apiModel: apiModel)
            store?.dispatch(.receive(message))
        }
    }
    
    private func createApiModel(message: Message) -> MessageApiModel {
        let textMessage = TextMessageApiModel(userId: UUID(), text: message.text)
        return MessageApiModel.text(textMessage)
    }
}

extension WebSocketMiddleware: ChatServiceDelegate {
    func didConnectionStatusChange(_ status: ConnectionStatus) {
        store?.dispatch(.connectionStatusChanged(status))
    }
}
