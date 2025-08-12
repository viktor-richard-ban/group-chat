//
//  Loader.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 06. 28..
//

import SwiftUI

struct Loader: View {
    private let text: String
    
    init(text: String) {
        self.text = text
    }
    
    var body: some View {
        ProgressView() {
            Text(text)
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .background(.gray.opacity(0.5))
    }
}

#Preview {
    Loader(text: "Connecting...")
}
