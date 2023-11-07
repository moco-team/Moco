//
//  BoardAnswer.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 02/11/23.
//

import SwiftUI

struct BoardAnswer: View {
    var label = "A"
    var fontSize = CGFloat(60)
    var position: CGPoint

    var onTap: () -> Void = {}

    var body: some View {
        Text(label).customFont(.didactGothic, size: fontSize).overlay {
            Color.clear
                .contentShape(Rectangle())
                .frame(width: Screen.width * 0.2, height: Screen.height * 0.4)
                .onTapGesture {
                    onTap()
                }
        }.position(position)
            .onTapGesture {
                print("\(label) clicked")
            }
    }
}

#Preview {
    BoardAnswer(label: "B", position: CGPoint(x: 0.5 * Screen.width, y: 0.62 * Screen.height)) {
        print("Boyy")
    }
}
