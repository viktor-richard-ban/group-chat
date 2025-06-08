//
//  ChatAction.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 06. 08..
//

enum ChatAction: CustomStringConvertible {
    case show(Message)
    
    var description: String {
        switch self {
        case .show(let message):
            "Show message: \(message)"
        }
    }
}
