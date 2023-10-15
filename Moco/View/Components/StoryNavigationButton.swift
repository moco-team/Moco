//
//  StoryNavigationButton.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 15/10/23.
//

import SwiftUI

enum Direction {
    case left
    case right
}

struct StoryNavigationButton: View {
    var width = 100.0
    var height = 100.0
    var direction = Direction.right

    var pressHandler: (() -> Void)?

    private let directionMap: [Direction: String] = [
        .left: "arrowtriangle.backward",
        .right: "arrowtriangle.forward"
    ]

    var body: some View {
        Button {
            pressHandler?()
        } label: {
            Image(systemName: directionMap[direction] ?? "arrowtriangle.forward").resizable().scaledToFit().padding(20)
        }.buttonStyle(CircleButton(width: width, height: height)).opacity(0.5)
    }
}

#Preview {
    StoryNavigationButton(direction: .left)
}
