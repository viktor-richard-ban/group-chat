//
//  SendButton.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 17..
//

import SwiftUI

struct SendButton: View {
    let action: @MainActor () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "paperplane")
        }
        .cornerRadius(16)
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    SendButton(action: {
        print("Hello World!")
    })
}
