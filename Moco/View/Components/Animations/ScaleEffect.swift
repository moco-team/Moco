//
//  ShakeEffect.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 14/11/23.
//

import SwiftUI

struct ScaleViewModifier: ViewModifier {
    @Environment(\.timerViewModel) private var timerViewModel
    @State private var isAnimated = false

    var minScale = 0.9
    var maxScale = 1.0

    var animation: Animation {
        Animation.easeInOut
            .repeatForever(autoreverses: true)
            .speed(0.5)
    }

    func body(content: Content) -> some View {
        content
            .scaleEffect(isAnimated ? minScale : maxScale)
            .onAppear {
                withAnimation(animation) {
                    isAnimated = true
                }
            }
    }
}

extension View {
    func scaleEffect(
        minScale: Double = 0.9,
        maxScale: Double = 1.0
    ) -> some View {
        modifier(
            ScaleViewModifier(minScale: minScale, maxScale: maxScale)
        )
    }
}
