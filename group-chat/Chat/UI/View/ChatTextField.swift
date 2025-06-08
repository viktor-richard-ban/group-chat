//
//  ChatTextField.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 17..
//

import SwiftUI

@Observable
final class ChatTextFieldState {
    var text: String
    let hint: String
    
    init(text: String, hint: String) {
        self.text = text
        self.hint = hint
    }
}

struct ChatTextField: View {
    @Bindable private var state: ChatTextFieldState
    @FocusState private var isFocused: Bool
    
    init(state: ChatTextFieldState) {
        self.state = state
    }
    
    var body: some View {
        TextField(state.hint, text: $state.text)
            .focused($isFocused)
            .frame(height: 40)
            .padding(.horizontal, 12)
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.gray, lineWidth: 1)
            }
    }
}

#Preview {
    ChatTextField(
        state: ChatTextFieldState(text: "", hint: "Message...")
    )
        .padding(.horizontal, 10)
}
