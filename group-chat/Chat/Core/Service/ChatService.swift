//
//  ChatService.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 19..
//

import Foundation

protocol ChatService {
    var delegate: ChatServiceDelegate? { get set }
    
    /// Sends a message and returns whether it was successful.
    ///
    /// - Parameter message: The message to send.
    /// - Throws: If sending fails due to network, encoding, or other errors.
    func send(message: MessageApiModel) throws
    
    /// Returns a stream of incoming messages.
    ///
    /// Use to asynchronously receive ``MessageApiModel`` values until the
    /// connection closes or the task is cancelled.
    ///
    /// - Returns: An ``AsyncStream`` of ``MessageApiModel``.
    func listen() -> AsyncStream<MessageApiModel>
}
