//
//  ChatService.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 19..
//

import Foundation

protocol ChatService {
    /// Sends a message and returns whether it was successful.
    ///
    /// - Parameter message: The message to send.
    /// - Returns: `true` if the message was sent successfully; `false` otherwise.
    /// - Throws: If sending fails due to network, encoding, or other errors.
    func send(message: MessageApiModel) async throws -> Bool
    func listen() -> AsyncStream<MessageApiModel>
}
