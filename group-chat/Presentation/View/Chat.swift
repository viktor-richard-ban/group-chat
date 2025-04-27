//
//  Chat.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 17..
//

import SwiftUI

struct Chat: View {
    @State private var viewModel: ChatViewModel
    
    init(viewModel: ChatViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            MessageList(messages: viewModel.messages.reversed())
            HStack(spacing: 12) {
                ChatTextField(state: viewModel.textFieldState)
                SendButton {
                    viewModel.send()
                }
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 4)
        }
    }
}

#Preview {
    let mockService = ChatServiceMock()
    Chat(viewModel: ChatViewModel(
        sendMessageUseCase: SendMessageUseCaseImpl(service: mockService),
        listenMessagesUseCase: ListenMessagesUseCaseImpl(service: mockService)
    ))
}
