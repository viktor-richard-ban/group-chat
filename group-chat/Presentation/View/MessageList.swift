//
//  Messages.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 16..
//

import SwiftUI

@Observable
final class MessageListState {
    var messages: [Message]
    var lastSeenMessageInfo: [UUID: [Character]]
    
    init(messages: [Message], lastSeenMessageInfo: [UUID: [Character]]) {
        self.messages = messages
        self.lastSeenMessageInfo = lastSeenMessageInfo
    }
}

struct MessageList: View {
    private let state: MessageListState
    
    init(state: MessageListState) {
        self.state = state
    }
    
    var body: some View {
        List {
            ForEach(state.messages) { message in
                VStack(alignment: .trailing, spacing: 4) {
                    MessageView(message: message)
                    SeenList(avatars: state.lastSeenMessageInfo[message.id] ?? [])
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
    MessageList(
        state: MessageListState(
            messages: [
                Message(id: UUID(uuidString: "12345678-1234-1234-1234-123456789012")!, text: "Sixth message", type: .received),
                Message(text: "Fifth message", type: .sent),
                Message(text: "Fourth message", type: .received),
                Message(text: "Third message", type: .received),
                Message(text: "Second message was very long and here we can test the multiline text view with some really long text.", type: .received),
                Message(text: "First message", type: .received),
            ],
            lastSeenMessageInfo: [
                UUID(uuidString: "12345678-1234-1234-1234-123456789012")!: ["C"]
            ]
        )
    )
}
