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
    @State private var rippleViewModel = RippleViewModel()
    @State private var resetOffset = false
    var position: CGPoint
    var isShowing = false

    private let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()

    var body: some View {
        VStack {
            Image(systemName: "hand.point.up.left.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.text.primary)
                .background {
                    ZStack {
                        ForEach(rippleViewModel.ripples, id: \.self) { ripple in
                            RippleView() {
                                rippleViewModel.removeRipple(id: ripple.id.uuidString)
                            }.allowsHitTesting(false)
                        }
                    }
                    .offset(x: -Screen.width * 0.025, y: -Screen.width * 0.025)
                }
                .frame(width: Screen.width * 0.05)
        }
        .position(position)
        .allowsHitTesting(false)
        .opacity(isShowing ? 1 : 0)
        .animation(.spring(duration: 0.5), value: isShowing)
        .onReceive(timer) { _ in
            if resetOffset {
                rippleViewModel.appendRipple(Ripple(xPosition: 0, yPosition: 0))
            }
            withAnimation {
                resetOffset.toggle()
            }
        }
        .offset(y: resetOffset ? 10 : 0)
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
