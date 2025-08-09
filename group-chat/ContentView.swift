//
//  ContentView.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 15..
//

import SwiftUI

struct ContentView: View {
    private var store: ChatStore {
        ChatStore(middlewares: [webSocketMiddleware])
    }
    
    private var viewModel: ChatViewModel {
        ChatViewModel(store: store)
    }
    private var webSocketMiddleware = WebSocketMiddleware( chatService: ChatServiceImpl())
    
    var body: some View {
        Chat(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
}
