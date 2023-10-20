//
//  FontViewModifier.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 19/10/23.
//

import SwiftUI

struct CustomFontViewModifier: ViewModifier {
    func getFont(fontType: CustomFontType) -> String {
        switch fontType {
        case .cherryBomb:
            return "CherryBomb-Regular"
        }
    }

    var fontType: CustomFontType = .cherryBomb
    var size: CGFloat = 24
    var relativeTo: Font.TextStyle = .body

    func body(content: Content) -> some View {
        content
            .font(
                .custom(
                    getFont(fontType: fontType),
                    size: size,
                    relativeTo: relativeTo
                )
            )
    }
}

extension View {
    func customFont(_ fontType: CustomFontType = .cherryBomb, size: CGFloat = 24, relativeTo: Font.TextStyle = .body) -> some View {
        modifier(CustomFontViewModifier(fontType: fontType, size: size, relativeTo: relativeTo))
    }
}
