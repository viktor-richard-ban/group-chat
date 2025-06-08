//
//  ChatService.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 19..
//

import Foundation

protocol ChatService {
    func send(message: MessageApiModel) throws
    func listen() -> AsyncStream<Message>
}
