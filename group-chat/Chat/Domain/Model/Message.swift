//
//  Message.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 17..
//

import Foundation

struct Message: Identifiable, Equatable {
    let id: UUID
    let text: String
    let type: MessageType
    
    init(id: UUID = UUID(), text: String, type: MessageType) {
        self.id = id
        self.text = text
        self.type = type
    }
    
    enum MessageType {
        case sent
        case received
    }
}
