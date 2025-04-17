//
//  ChatTextField.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 17..
//

import SwiftUI

struct ChatTextField: View {
    @FocusState private var isFocused: Bool
    @Binding var text: String
    let hint: String
    
    var body: some View {
        TextField(hint, text: $text)
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
    ChatTextField(text: .constant(""), hint: "Message...")
        .padding(.horizontal, 10)
}
