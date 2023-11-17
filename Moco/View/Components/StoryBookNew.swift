//
//  StoryBookNew.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 28/10/23.
//

import MediaPlayer
import SwiftUI

struct StoryBookNew: View {
    // MARK: - Stored variable definition

    @Environment(\.font) private var font

    let durationAndDelay: CGFloat = 0.3
    var image: String? = "Story/Cover/Story1"
    var firstPageBackground: String
    var number: Int = 1
    var isLocked = false
    @State private var peelEffectState = PeelEffectState.stop

    var tapHandler: (() -> Void)?

    var width: CGFloat {
        Screen.width * 0.3
    }

    var height: CGFloat {
        Screen.height * 0.3
    }

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(.white)
                    .frame(
                        width: width,
                        height: height
                    ) // Adjust the frame size as needed
                    .clipShape(
                        .rect(
                            topLeadingRadius: 16,
                            bottomLeadingRadius: 16,
                            bottomTrailingRadius: 32,
                            topTrailingRadius: 32
                        )
                    )

                Image(firstPageBackground)
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: width,
                        height: height
                    ) // Adjust the frame size as needed
                    .clipShape(
                        .rect(
                            topLeadingRadius: 8,
                            bottomLeadingRadius: 8,
                            bottomTrailingRadius: 24,
                            topTrailingRadius: 24
                        )
                    )

                PeelEffect(state: $peelEffectState) {
                    VStack {
                        VStack {
                            ZStack {
                                Rectangle()
                                    .fill(.white)
                                    .frame(
                                        width: width + 20,
                                        height: height + 20
                                    ) // Adjust the frame size as needed
                                    .clipShape(
                                        .rect(
                                            topLeadingRadius: 16,
                                            bottomLeadingRadius: 16,
                                            bottomTrailingRadius: 32,
                                            topTrailingRadius: 32
                                        )
                                    )
                                Image(image ?? "")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(
                                        width: width,
                                        height: height
                                    ) // Adjust the frame size as needed
                                    .overlay {
                                        if isLocked {
                                            Color.black.opacity(0.4)
                                                .overlay {
                                                    Image("Story/Cover/locked")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 100)
                                                }
                                        } else {
                                            EmptyView()
                                        }
                                    }
                                    .clipShape(
                                        .rect(
                                            topLeadingRadius: 8,
                                            bottomLeadingRadius: 8,
                                            bottomTrailingRadius: 24,
                                            topTrailingRadius: 24
                                        )
                                    )
                            }
                            .overlay {
                                if !isLocked {
                                    ZStack {
                                        Image("Story/Cover/bookmark")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 70, height: 70)
                                            .opacity(0.5)

                                        Text("\(number)")
                                            .customFont(size: 30)
                                            .foregroundColor(Color.brownTxt)
                                            .fontWeight(.bold)
                                            .padding(.bottom, 1)
                                            .offset(x: 0, y: -9)
                                    }
                                    .position(x: 53, y: 41)
                                } else {
                                    EmptyView()
                                }
                            }
                        }
                    }
                } background: {} onComplete: {
                    guard !isLocked else { return }
                    tapHandler?()
                }
                .onTapGesture {
                    guard !isLocked else { return }
                    peelEffectState = .start
                }
            }
        }
    }
}

#Preview {
    StoryBookNew(firstPageBackground: "Story/Cover/Story1")
}
