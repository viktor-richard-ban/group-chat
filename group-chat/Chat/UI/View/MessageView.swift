//
//  Message.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 16..
//

import SwiftUI

struct MessageView: View {
    let message: Message
    
    var body: some View {
        if (message.type == .sent) {
            HStack {
                Spacer()
                TextMessage(text: message.text)
                    .padding(.leading, 15)
            }
        } else {
            HStack(alignment: .bottom, spacing: 5) {
                Avatar(
                    character: "C",
                    backgroundColor: Color(hue: 0.9, saturation: 0.8, brightness: 1)
                )
                .frame(width: 30, height: 30)
                TextMessage(text: message.text)
                    .padding(.trailing, 15)
                Spacer()
            }
        }
    }
}

#Preview {
    VStack {
        MessageView(
            message: Message(text: "More then one line\nto test multiline message", type: .received)
        )
        MessageView(
            message: Message(text: "More then one line\nto test multiline message", type: .sent)
        )
    }
}
