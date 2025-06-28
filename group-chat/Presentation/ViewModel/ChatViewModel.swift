//
//  ChatViewModel.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 19..
//

import Foundation
import SwiftUICore

@Observable
@MainActor
final class ChatViewModel {
    var isConnecting: Bool = false
    var messageListState: MessageListState = MessageListState(messages: [], lastSeenMessageInfo: [:])
    var textFieldState: ChatTextFieldState = ChatTextFieldState(text: "", hint: "Message...")
    
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
            if message.type == .connectivity {
                handleConnectivityMessage(message: message)
                continue
            }
            insert(new: message)
        }
    }
    
    func send() {
        guard !textFieldState.text.isEmpty else { return }
        insert(new: Message(text: textFieldState.text, type: .sent))
        sendMessageUseCase.execute(message: textFieldState.text)
        textFieldState.text = ""
    }
    
    private func insert(new message: Message) {
        // TODO: - [#12] Remove reversed in order not to reverse the whole list every time we get a new message
        messageListState.messages.insert(message, at: 0)
        lastSeenMessage(by: "C", messageId: message.id)
    }
    
    private func lastSeenMessage(by user: Character, messageId: UUID) {
        messageListState.lastSeenMessageInfo.removeAll()
        messageListState.lastSeenMessageInfo[messageId] = [user]
    }
    
    private func handleConnectivityMessage(message: Message) {
        guard message.type == .connectivity,
        let status = ConnectionStatus(rawValue: message.text) else { return }
        
        if status == .connected && isConnecting {
            isConnecting = false
        } else if status == .disconnected && !isConnecting  {
            isConnecting = true
        }
    }
}
