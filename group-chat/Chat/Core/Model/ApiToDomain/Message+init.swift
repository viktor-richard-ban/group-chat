//
//  Message+init.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 08. 09..
//

extension Message {
    init(apiModel: MessageApiModel) {
        switch apiModel {
        case .text(let textMessage):
            self.id = textMessage.userId
            self.text = textMessage.text
            self.type = .received
        }
    }
}
