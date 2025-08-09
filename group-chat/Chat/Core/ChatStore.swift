//
//  ChatStore.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 06. 08..
//

import Combine
import OSLog

final class ChatStore: Store {
    typealias State = ChatState
    typealias Action = ChatAction
    
    var middlewares: [any Middleware] = []
    var state: Published<ChatState>.Publisher { $statePublisher }
    @Published private var statePublisher: ChatState = ChatState.default
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "", category: "ChatStore")
    
    init(middlewares: [any Middleware]) {
        self.middlewares = middlewares
        for middleware in middlewares {
            middleware.attach(store: self)
        }
    }
    
    func dispatch(_ action: ChatAction) {
        reduce(action)
        for middleware in middlewares {
            middleware.handle(action: action)
        }
    }
    
    private func reduce(_ action: ChatAction) {
        logger.debug("\(Self.self) received an action: \(action)")
        switch action {
        case .send(let message), .receive(let message):
            var newState = statePublisher
            newState.messages.append(message)
            statePublisher = newState
        case .connectionStatusChanged(let status):
            var newState = statePublisher
            newState.connection = status
            statePublisher = newState
        }
    }
}
