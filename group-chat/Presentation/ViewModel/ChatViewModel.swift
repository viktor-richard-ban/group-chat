//
//  ChatViewModel.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 19..
//

import Foundation
import SwiftUICore

@Observable
class ChatViewModel {
    @MainActor var messages: [Message] = []
    @MainActor var textFieldState: ChatTextFieldState = ChatTextFieldState(text: "", hint: "Message...")
    
    private let sendMessageUseCase: SendMessageUseCase
    private let listenMessagesUseCase: ListenMessagesUseCase
    
    init(sendMessageUseCase: SendMessageUseCase,
         listenMessagesUseCase: ListenMessagesUseCase) {
        self.sendMessageUseCase = sendMessageUseCase
        self.listenMessagesUseCase = listenMessagesUseCase
        Task {
            await listen()
        }
    }
    
    @MainActor
    func listen() async {
        for await message in listenMessagesUseCase.listen() {
            messages.append(Message(text: message, type: .received))
        }
    }
    
    @MainActor
    func send() {
        guard !textFieldState.text.isEmpty else { return }
        messages.append(Message(text: textFieldState.text, type: .sent))
        sendMessageUseCase.execute(message: textFieldState.text)
        textFieldState.text = ""
    }
}
