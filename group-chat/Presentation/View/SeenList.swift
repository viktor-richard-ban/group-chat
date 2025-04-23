//
//  SeenList.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 23..
//

import SwiftUI

struct SeenList: View {
    let avatars: [String] = [["Z", "K", "P"], ["A", "B"], ["A"], [], [], [], []].randomElement() ?? []
    var filteredAvatars: [String] {
        if avatars.count > 2 {
            var avatars2 = avatars.dropLast(avatars.count - 2)
            avatars2.append("+")
            return Array(avatars2)
        }
        return avatars
    }
    
    var body: some View {
        HStack(spacing: -5) {
            ForEach(filteredAvatars, id: \.self) { avatar in
                Avatar(
                    character: avatar,
                    backgroundColor: [Color.red, Color.green, Color.cyan].randomElement() ?? .blue
                )
                .frame(width: 18, height: 18)
            }
        }
    }
}
