//
//  TextViewModifier.swift
//  Moco
//
//  Created by Carissa Farry Hilmi Az Zahra on 02/11/23.
//

import SwiftUI

struct GlowBorder: ViewModifier {
    var color: Color
    var lineWidth: Int

    func body(content: Content) -> some View {
        applyShadow(content: AnyView(content), lineWidth: lineWidth)
    }

    func applyShadow(content: AnyView, lineWidth: Int) -> AnyView {
        if lineWidth == 0 {
            return content
        } else {
            return applyShadow(content: AnyView(content.shadow(color: color, radius: 1)), lineWidth: lineWidth - 1)
        }
    }
}

extension View {
    func glowBorder(color: Color, lineWidth: Int) -> some View {
        modifier(GlowBorder(color: color, lineWidth: lineWidth))
    }
}
