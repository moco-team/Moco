//
//  ShakeEffect.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 14/11/23.
//

import SwiftUI

struct ShakeEffect: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size _: CGSize) -> ProjectionTransform {
        ProjectionTransform(
            CGAffineTransform(
                translationX: amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
                y: 0
            )
        )
    }
}

struct ShakeViewModifier: ViewModifier {
    @Environment(\.timerViewModel) private var timerViewModel
    @State private var internalShakeTimer = TimerViewModel()
    @State private var shakeAnimatableData: CGFloat = 0

    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat
    var interval: TimeInterval = 2
    var loop = true

    func body(content: Content) -> some View {
        content
            .modifier(
                ShakeEffect(
                    amount: amount,
                    shakesPerUnit: shakesPerUnit,
                    animatableData: shakeAnimatableData
                )
            )
            .onDisappear {
                internalShakeTimer.stopTimer("shakeTimer")
            }
            .task {
                if animatableData != 0 {
                    if loop {
                        internalShakeTimer.setTimer(key: "shakeTimer", withInterval: interval) {
                            DispatchQueue.main.asyncAfter(deadline: .now()) {
                                withAnimation {
                                    shakeAnimatableData = shakeAnimatableData == 0 ? 1 : 0
                                }
                            }
                        }
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
                            withAnimation {
                                shakeAnimatableData = shakeAnimatableData == 0 ? 1 : 0
                            }
                        }
                    }
                }
            }
    }
}

extension View {
    func shake(
        animatableData: CGFloat,
        amount: CGFloat = 10,
        shakesPerUnit: Int = 3,
        interval: TimeInterval = 2,
        loop: Bool = true
    ) -> some View {
        modifier(
            ShakeViewModifier(
                amount: amount,
                shakesPerUnit: shakesPerUnit,
                animatableData: animatableData,
                interval: interval,
                loop: loop
            )
        )
    }
}
