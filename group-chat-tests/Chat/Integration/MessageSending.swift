//
//  MessageSending.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 08. 09..
//

@testable import Group_Chat
import Foundation
import Testing

@MainActor
struct MessageSending {
    private let chatService: ChatServiceMock
    private let chatStore: ChatStore
    private let sut: ChatViewModel
    
    init() {
        self.chatService = ChatServiceMock()
        let middlewares: [Middleware] = [
            WebSocketMiddleware( chatService: chatService)
        ]
        self.chatStore = ChatStore(middlewares: middlewares)
        self.sut = ChatViewModel(store: chatStore)
    }
}

// MARK: Test cases
extension MessageSending {
    @Test("Sent message mapped to API model and sent to the service")
    func sentMessageArrivesToServiceAsMessageAPIModel() async throws {
        // Given
        let messageToSend: String = "message"
        sut.textFieldState.text = messageToSend
        
        // When
        sut.send()
        
        // Then
        // UserID is not checked until proper user handling implemented
        let textMessageAPIModel = TextMessageApiModel(type: .text, userId: UUID(), text: messageToSend)
        let expectedMessageAPIModel = MessageApiModel.text(textMessageAPIModel)
        #expect(chatService.sentMessages == [expectedMessageAPIModel])
    }
}
