//
//  ChatState.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 06. 08..
//

struct ChatState: Equatable {
    var messages: [Message]
    var connection: ConnectionStatus
}

extension ChatState {
    static let `default`: Self = ChatState(messages: [], connection: .disconnected)
}
