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
    
    var state: Published<ChatState>.Publisher { $statePublisher }
    @Published private var statePublisher: ChatState = ChatState(messages: [])
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "", category: "ChatStore")
    
    func reduce(_ action: ChatAction) {
        logger.debug("\(Self.self) received an action: \(action)")
        switch action {
        case .show(let message):
            var newState = self.statePublisher
            newState.messages.append(message)
            statePublisher = newState
        }
    }
}
