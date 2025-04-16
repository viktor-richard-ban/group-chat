//
//  Messages.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 16..
//

import SwiftUI

struct Messages: View {
    let messages: [String]
    
    var body: some View {
        List(messages, id: \.self) { message in
            Message(text: message)
                .listRowSeparator(.hidden)
                .modifier(Flipped())
        }
        .listStyle(.plain)
        .modifier(Flipped())
    }
}

#Preview {
    Messages(messages: [
        "First message",
        "Second message was very long and here we can test the multiline text view with some really long text.",
        "Third message",
        "Fourth message",
        "Fifth message",
        "Sixth message"
    ])
}
