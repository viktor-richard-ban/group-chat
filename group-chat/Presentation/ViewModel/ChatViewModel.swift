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
    @MainActor var messageListState: MessageListState = MessageListState(messages: [], lastSeenMessageInfo: [:])
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
            insert(new: Message(text: message, type: .received))
        }
    }
    
    @MainActor
    func send() {
        guard !textFieldState.text.isEmpty else { return }
        insert(new: Message(text: textFieldState.text, type: .sent))
        sendMessageUseCase.execute(message: textFieldState.text)
        textFieldState.text = ""
    }
    
    @MainActor
    private func insert(new message: Message) {
        // TODO: - [#12] Remove reversed in order not to reverse the whole list every time we get a new message
        messageListState.messages.insert(message, at: 0)
        lastSeenMessage(by: "C", messageId: message.id)
    }
    
    @MainActor
    private func lastSeenMessage(by user: Character, messageId: UUID) {
        messageListState.lastSeenMessageInfo.removeAll()
        messageListState.lastSeenMessageInfo[messageId] = [user]
    }
}
