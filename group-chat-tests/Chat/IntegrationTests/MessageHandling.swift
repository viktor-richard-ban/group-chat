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
@Suite("Message sending and receiving", .tags(.integration_test))
struct MessageHandling {
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
extension MessageHandling {
    @Test("Sent message mapped to API model and sent to the service and text field is cleared")
    func sentMessageArrivesToServiceAsMessageAPIModel_andTextFieldCleared() async throws {
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
        #expect(sut.textFieldState.text == "")
    }
    
    @Test("Received message is showing up in to the message list")
    func receivedMessage() async throws {
        // When
        let messageToReceive = MessageApiModel.text(TextMessageApiModel(userId: UUID(), text: "Received message"))
        chatService.receiveMessage(messageToReceive)
        
        // Then
        let expectedMessage = Message(apiModel: messageToReceive)
        #expect(sut.messageListState.messages == [expectedMessage])
    }
}
