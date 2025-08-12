//
//  TextMessageApiModel+Equatable.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 08. 10..
//

@testable import Group_Chat

extension TextMessageApiModel: @retroactive Equatable {
    public static func == (lhs: TextMessageApiModel, rhs: TextMessageApiModel) -> Bool {
        return lhs.type == rhs.type && lhs.text == rhs.text
    }
}
