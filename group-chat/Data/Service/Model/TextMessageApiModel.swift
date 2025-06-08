//
//  TextMessageApiModel.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 06. 03..
//

import Foundation

struct TextMessageApiModel: Codable {
    var type: MessageTypeApiModel = .text
    let userId: UUID
    let text: String
}
