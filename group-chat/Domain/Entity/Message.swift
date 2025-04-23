//
//  Message.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 17..
//

import Foundation

struct Message: Identifiable {
    let id: UUID = UUID()
    let text: String
    let type: MessageType
    let seen: [String]
    
    init(text: String, type: MessageType, seen: [String] = []) {
        self.text = text
        self.type = type
        self.seen = seen
    }
}
