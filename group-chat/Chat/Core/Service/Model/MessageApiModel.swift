//
//  Message.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 05. 11..
//

import Foundation

enum MessageApiModel: Codable {
    case text(TextMessageApiModel)

    enum CodingKeys: String, CodingKey {
        case type
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(MessageTypeApiModel.self, forKey: .type)

        switch type {
        case .text:
            self = .text(try TextMessageApiModel(from: decoder))
        }
    }

    func encode(to encoder: Encoder) throws {
        switch self {
        case .text(let msg):
            try msg.encode(to: encoder)
        }
    }
}

