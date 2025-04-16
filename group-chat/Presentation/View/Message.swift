//
//  Message.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 16..
//

import SwiftUI

struct Message: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 5) {
            Avatar(
                character: "C",
                backgroundColor: Color(hue: 0.9, saturation: 0.8, brightness: 1)
            )
            .frame(width: 30, height: 30)
            TextMessage(text: text)
        }
    }
}

#Preview {
    Message(text: "More then one line\nto test multiline message")
}
