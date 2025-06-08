//
//  ChatViewModel.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 19..
//

import Foundation
import SwiftUICore
import Combine

@Observable
@MainActor
final class ChatViewModel {
    var messageListState: MessageListState = MessageListState(messages: [], lastSeenMessageInfo: [:])
    var textFieldState: ChatTextFieldState = ChatTextFieldState(text: "", hint: "Message...")
    
    private let sendMessageUseCase: SendMessageUseCase
    private let listenMessagesUseCase: ListenMessagesUseCase
    private let chatState: Published<ChatState>.Publisher
    private var cancellables: Set<AnyCancellable> = []
    
    init(sendMessageUseCase: SendMessageUseCase,
         listenMessagesUseCase: ListenMessagesUseCase,
         chatState: Published<ChatState>.Publisher) {
        self.sendMessageUseCase = sendMessageUseCase
        self.listenMessagesUseCase = listenMessagesUseCase
        self.chatState = chatState
        
        listen()
    }
    
    func listen() {
        listenMessagesUseCase.listen()
        chatState.map(\.messages)
            .sink { [messageListState] messages in
                messageListState.messages = messages.reversed()
            }
            .store(in: &cancellables)
    }
    
    func send() {
        guard !textFieldState.text.isEmpty else { return }
        sendMessageUseCase.send(message: textFieldState.text)
        textFieldState.text = ""
    }
}
