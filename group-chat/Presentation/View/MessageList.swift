//
//  Messages.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 16..
//

import SwiftUI

struct MessageList: View {
    let messages: [Message]
    
    var body: some View {
        List {
            ForEach(messages) { message in
                VStack(alignment: .trailing, spacing: 4) {
                    MessageView(message: message)
                    SeenList()
                }
            }
            .listRowSeparator(.hidden)
            .listRowInsets(
                EdgeInsets(top: 6, leading: 12, bottom: 6, trailing: 12)
            )
            .modifier(Flipped())
        }
        .listStyle(.plain)
        .modifier(Flipped())
    }
}

#Preview {
    MessageList(messages: [
        Message(text: "First message", type: .received),
        Message(text: "Second message was very long and here we can test the multiline text view with some really long text.", type: .received),
        Message(text: "Third message", type: .received),
        Message(text: "Fourth message", type: .received),
        Message(text: "Fifth message", type: .sent),
        Message(text: "Sixth message", type: .received)
    ])
}
