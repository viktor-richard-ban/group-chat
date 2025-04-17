//
//  Chat.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 17..
//

import SwiftUI

struct Chat: View {
    @State private var messages: [Message] = [
        Message(text: "First message", type: .received),
        Message(text: "Second message was very long and here we can test the multiline text view with some really long text.", type: .received),
        Message(text: "Third message", type: .received)
    ]
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            Messages(messages: messages.reversed())
            HStack(spacing: 12) {
                ChatTextField(text: $text, hint: "Message...")
                SendButton {
                    messages.append(Message(text: text, type: .sent))
                    text = ""
                }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 4)
        }
    }
}

#Preview {
    Chat()
}
