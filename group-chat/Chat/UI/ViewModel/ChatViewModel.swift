//
//  ChatViewModel.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 19..
//

import Foundation
import SwiftUI
import Combine

@Observable
@MainActor
final class ChatViewModel {
    var isConnecting: Bool = false
    var messageListState: MessageListState = MessageListState(messages: [], lastSeenMessageInfo: [:])
    var textFieldState: ChatTextFieldState = ChatTextFieldState(text: "", hint: "Message...")

    private let store: ChatStore
    private var bag: Set<AnyCancellable> = Set()
    
    init(store: ChatStore) {
        self.store = store
        bind()
    }
    
    func bind() {
        store.state.removeDuplicates()
            .sink { [weak self] (state: ChatState) in
                guard let self else { return }
                self.messageListState.messages = state.messages.reversed()
                self.isConnecting = state.connection == .disconnected
            }
            .store(in: &bag)

    }
    
    func send() {
        guard !textFieldState.text.isEmpty else { return }
        let message = Message(text: textFieldState.text, type: .sent)
        store.dispatch(.send(message))
        textFieldState.text = ""
    }
}
