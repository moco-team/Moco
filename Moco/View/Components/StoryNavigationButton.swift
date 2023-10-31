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
    var width = 140.0
    var height = 100.0
    var direction: Direction

    var pressHandler: (() -> Void)?

    private let directionMap: [Direction: String] = [
        .left: "Buttons/button-left",
        .right: "Buttons/button-right"
    ]

    var body: some View {
        Button {
            pressHandler?()
        } label: {
            Image(directionMap[direction]!)
                .resizable()
                .scaledToFit()
        }.buttonStyle(ImageButton(width: width, height: height))
    }
}

struct StoryNavigationButtonOld: View {
    var width = 100.0
    var height = 100.0
    var direction: Direction

    var pressHandler: (() -> Void)?

    private let directionMap: [Direction: String] = [
        .left: "arrowtriangle.backward",
        .right: "arrowtriangle.forward"
    ]

    var body: some View {
        Button {
            pressHandler?()
        } label: {
            Image(systemName: directionMap[direction]!)
                .resizable()
                .scaledToFit()
                .padding(.leading, direction == .right ? 12 : 0)
                .padding(.trailing, direction == .left ? 12 : 0)
                .padding(.vertical, 24)
        }.buttonStyle(CircleButton(width: width, height: height)).opacity(0.5)
    }
}

#Preview {
    HStack(spacing: 40) {
        StoryNavigationButton(direction: .left)
        StoryNavigationButton(direction: .right)
    }
}
