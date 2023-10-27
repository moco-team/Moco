//
//  RootViewModifier.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 19/10/23.
//

import SwiftUI

struct RootViewModifier: ViewModifier {
    @State private var rippleViewModel = RippleViewModel()

    func body(content: Content) -> some View {
        ZStack {
            content
                .edgesIgnoringSafeArea(.all)
                .statusBar(hidden: true)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .ignoresSafeArea()
                .onTapGesture { location in
                    rippleViewModel.appendRipple(Ripple(xPosition: location.x, yPosition: location.y))
                }
            ForEach(rippleViewModel.ripples, id: \.self) { ripple in
                RippleView(xPosition: ripple.xPosition, yPosition: ripple.yPosition) {
                    rippleViewModel.removeRipple(id: ripple.id.uuidString)
                }.allowsHitTesting(false)
                    .onTapGesture { location in
                        rippleViewModel.appendRipple(Ripple(xPosition: location.x, yPosition: location.y))
                    }
            }
        }
    }
}

extension View {
    func rootViewModifier() -> some View {
        modifier(RootViewModifier())
    }
}
