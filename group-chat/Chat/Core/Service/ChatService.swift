//
//  ChatService.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 19..
//

import Foundation
import Combine

protocol ChatService {
    var delegate: ChatServiceDelegate? { get set }
    /// Returns a stream of incoming messages.
    ///
    /// Use to asynchronously receive ``MessageApiModel`` values until the
    /// connection closes or the task is cancelled.
    var messageStream: AnyPublisher<MessageApiModel, Never> { get }
    
    /// Sends a message and returns whether it was successful.
    ///
    /// - Parameter message: The message to send.
    /// - Throws: If sending fails due to network, encoding, or other errors.
    func send(message: MessageApiModel) throws
}
