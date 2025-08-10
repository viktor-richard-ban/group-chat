//
//  MessageApiModel+init.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 08. 10..
//

@testable import Group_Chat

extension MessageApiModel: @retroactive Equatable {
    public static func == (lhs: Group_Chat.MessageApiModel, rhs: Group_Chat.MessageApiModel) -> Bool {
        switch (lhs, rhs) {
        case (.text(let lhsMsg), .text(let rhsMsg)):
            return lhsMsg == rhsMsg
        }
    }
}
