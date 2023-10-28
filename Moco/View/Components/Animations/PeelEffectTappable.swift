//
//  PeelEffectTappable.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 28/10/23.
//

import SwiftUI

struct PeelEffectTappable<Content: View, Background: View>: View {
    var content: Content
    var background: Background

    var onComplete: () -> Void = {}

    var maxProgress = 0.8

    @Binding var state: PeelEffectState

    init(
        state: Binding<PeelEffectState>,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder background: @escaping () -> Background,
        onComplete: (() -> Void)? = nil
    ) {
        self.content = content()
        self.onComplete = onComplete ?? {}
        self.background = background()
        _state = state
    }

    @State private var dragProgress: CGFloat = 0
    @State private var onCompleteExecuted = false

    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()

    var body: some View {
        content
            .mask {
                GeometryReader {
                    let rect = $0.frame(in: .global)
                    Rectangle()
                        .padding(.trailing, dragProgress * rect.width)
                }
            }
            .overlay {
                GeometryReader {
                    let size = $0.size
                    let minOpacity = dragProgress / 0.05

                    content
                        .shadow(color: .black.opacity(dragProgress != 0 ? 0.1 : 0), radius: 5, x: 15, y: 0)
                        .overlay {
                            Rectangle()
                                .fill(.white.opacity(0.25))
                                .mask(content)
                        }
                        /// Making it glow at the back side
                        .overlay(alignment: .trailing) {
                            Rectangle()
                                .fill(
                                    .linearGradient(colors: [
                                        .clear,
                                        .white,
                                        .clear,
                                        .clear
                                    ],
                                    startPoint: .leading,
                                    endPoint: .leading)
                                )
                                .frame(width: 60)
                                .offset(x: 40)
                                .offset(x: -30 + (30 * minOpacity))
                                .offset(x: size.width * -dragProgress)
                        }
                        .scaleEffect(x: -1)
                        .offset(x: size.width - (size.width * dragProgress))
                        .offset(x: size.width * -dragProgress)
                        .mask {
                            Rectangle()
                                .offset(x: size.width * -dragProgress)
                        }
                        .contentShape(Rectangle())
                }
                .allowsHitTesting(false)
            }
            .background {
                GeometryReader {
                    let rect = $0.frame(in: .global)
                    Rectangle()
                        .fill(.black)
                        .padding(.vertical, 23)
                        .shadow(color: .black.opacity(0.3), radius: 15, x: 30, y: 0)
                        .padding(.trailing, rect.width * dragProgress)
                }
                .mask(content)
            }
            .background {
                background
            }
            .onReceive(timer) { _ in
                switch self.state {
                case .start:
                    if dragProgress < maxProgress {
                        dragProgress += 0.1
                    } else if !onCompleteExecuted {
                        onComplete()
                        onCompleteExecuted = true
                    }
                case .stop: break
                case .reverse:
                    if dragProgress >= 0.1 {
                        dragProgress -= 0.1
                    }
                }
            }
            .onAppear {
                onCompleteExecuted = false
            }
    }
}

#Preview {
    @State var peelState = PeelEffectState.start

    return PeelEffectTappable(state: $peelState) {
        StoryBook {
            print("waduh")
        }
    } background: {
        Image("Story/Cover/Story1")
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 280) // Adjust the frame size as needed
            .clipShape(
                .rect(
                    topLeadingRadius: 8,
                    bottomLeadingRadius: 8,
                    bottomTrailingRadius: 24,
                    topTrailingRadius: 24
                )
            )
    } onComplete: {
        print("woi")
    }
}
