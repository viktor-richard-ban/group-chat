//
//  SeenList.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 23..
//

import SwiftUI

struct SeenList: View {
    var avatars: [Character] = []
    
    var body: some View {
        HStack(spacing: -5) {
            ForEach(avatars, id: \.self) { avatar in
                Avatar(
                    character: avatar,
                    backgroundColor: [Color.red, Color.green, Color.cyan].randomElement() ?? .blue
                )
                .frame(width: 18, height: 18)
            }
        }
    }
}
