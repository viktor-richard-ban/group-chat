//
//  TextMessage.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 16..
//

import SwiftUI

struct TextMessage: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 15))
            .foregroundStyle(.white)
            .padding(10)
            .background {
                RoundedRectangle(
                    cornerSize: CGSize(width: 15, height: 15),
                    style: .circular
                )
                .fill(.blue)
            }
    }
}

#Preview {
    TextMessage(text: "Test")
}
