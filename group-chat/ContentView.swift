//
//  ContentView.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 15..
//

import SwiftUI

struct ContentView: View {
    private let chatService = ChatServiceImpl()
    private var viewModel: ChatViewModel {
        ChatViewModel(
            sendMessageUseCase: SendMessageUseCaseImpl(service: chatService),
            listenMessagesUseCase: ListenMessagesUseCaseImpl(service: chatService)
        )
    }
    
    var body: some View {
        Chat(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
}
