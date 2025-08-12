//
//  ChatAction.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 06. 08..
//

enum ChatAction: Action, CustomStringConvertible {
    case send(Message)
    case receive(Message)
    case connectionStatusChanged(ConnectionStatus)
    
    var description: String {
        switch self {
        case .send(let message):
            "Show message: \(message)"
        case .receive(let message):
            "Receive message: \(message)"
        case .connectionStatusChanged(let connectionStatus):
            "Connection status changed to: \(connectionStatus)"
        }
    }
}
