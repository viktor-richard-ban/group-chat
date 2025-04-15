//
//  Avatar.swift
//  group-chat
//
//  Created by Viktor Bán on 2025. 04. 15..
//

import SwiftUI

struct Avatar: View {
    let character: String
    let backgroundColor: Color
    
    var body: some View {
        GeometryReader { geometry in
            let size = min(geometry.size.width, geometry.size.height)
            let fontSize = geometry.size.width * 0.5
            
            ZStack {
                Circle()
                    .fill(backgroundColor)
               
                Text(character)
                    .font(.system(size: fontSize, weight: .semibold))
                    .foregroundColor(.white)
            }
            .frame(width: size, height: size)
        }
    }
}

#Preview {
    Avatar(character: "F", backgroundColor: .blue)
        .frame(width: 100, height: 100)
}
