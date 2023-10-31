//
//  PointerViewModifier.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 31/10/23.
//

import SwiftUI

public extension View {
    func pointer(
        position: CGPoint,
        isShowing: Bool = false
    ) -> some View {
        modifier(
            PointerViewModifier(position: position, isShowing: isShowing)
        )
    }
}
