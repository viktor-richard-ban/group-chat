//
//  ContentView.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 15..
//

import SwiftUI

struct ContentView: View {
    private let chatService = ChatServiceImpl()
    private let store: ChatStore = ChatStore()
    
    private var viewModel: ChatViewModel {
        ChatViewModel(
            sendMessageUseCase: SendMessageUseCaseImpl(service: chatService, store: store),
            listenMessagesUseCase: ListenMessagesUseCaseImpl(service: chatService, store: store),
            chatState: store.state
        )
    }
    
    var body: some View {
        Chat(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
}
