//
//  ChatState.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 06. 08..
//

struct ChatState {
    var messages: [Message] = []
    
    init(messages: [Message]) {
        self.messages = messages
    }
}
