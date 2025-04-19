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
    var messages: [Message] = []
    var text: String = ""
    
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
    
    func listen() async {
        for await message in listenMessagesUseCase.listen() {
            messages.append(Message(text: message, type: .received))
        }
    }
    
    func send() {
        guard !text.isEmpty else { return }
        messages.append(Message(text: text, type: .sent))
        sendMessageUseCase.execute(message: text)
        text = ""
    }
}
