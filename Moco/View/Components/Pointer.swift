//
//  Pointer.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 31/10/23.
//

import SwiftUI

/// How to use
///
/// content.pointer(location: CGPoint(), isShowing: false)
struct PointerViewModifier: ViewModifier {
    var position: CGPoint
    var isShowing = false

    func body(content: Content) -> some View {
        content.overlay {
            Pointer(
                position: position,
                isShowing: isShowing
            )
        }
    }
}

struct Pointer: View {
    var position: CGPoint
    var isShowing = false

    var body: some View {
        VStack {
            Image(systemName: "hand.point.up.left.fill").resizable().scaledToFit().frame(width: 100).foregroundColor(Color.text.primary)
        }.position(position).allowsHitTesting(false).opacity(isShowing ? 1 : 0)
            .animation(.spring(duration: 0.5), value: isShowing)
    }
}

struct PointerView: View {
    @State var showPointer = true

    var body: some View {
        VStack {
            Button("Toggle") {
                showPointer.toggle()
            }
            Pointer(position: .init(x: 200, y: 200), isShowing: showPointer)
        }
    }
}

#Preview {
    PointerView()
}
