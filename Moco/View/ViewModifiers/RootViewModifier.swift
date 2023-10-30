//
//  RootViewModifier.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 19/10/23.
//

import SwiftUI

struct RootViewModifier: ViewModifier {
    @State private var rippleViewModel = RippleViewModel()
    @GestureState private var pressing = false
    @GestureState private var location: CGPoint = .zero

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
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .updating($pressing) { _, state, _ in
                            state = true
                        }
                        .updating($location) { value, state, _ in
                            state = value.location
                            rippleViewModel.appendRipple(Ripple(xPosition: location.x, yPosition: location.y))
                        }
                        .onEnded { _ in
                            // Handle the long press gesture end event
                        }
                )
            ForEach(rippleViewModel.ripples, id: \.self) { ripple in
                RippleView(xPosition: ripple.xPosition, yPosition: ripple.yPosition) {
                    rippleViewModel.removeRipple(id: ripple.id.uuidString)
                }.allowsHitTesting(false)
                    .onTapGesture { location in
                        rippleViewModel.appendRipple(Ripple(xPosition: location.x, yPosition: location.y))
                    }
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .updating($pressing) { _, state, _ in
                                state = true
                            }
                            .updating($location) { value, state, _ in
                                state = value.location
                                rippleViewModel.appendRipple(Ripple(xPosition: location.x, yPosition: location.y))
                            }
                            .onEnded { _ in
                                // Handle the long press gesture end event
                            }
                    )
            }
        }
    }
}

extension View {
    func rootViewModifier() -> some View {
        modifier(RootViewModifier())
    }
}
