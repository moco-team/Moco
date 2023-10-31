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

    var title: String = "Story 1"
    let durationAndDelay: CGFloat = 0.3
    var image: String? = "Story/Cover/Story1"
    var firstPageBackground: String?
    var number: Int = 1
    @State private var peelEffectState = PeelEffectState.stop

    var tapHandler: (() -> Void)?

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(.white)
                    .frame(width: 220, height: 300) // Adjust the frame size as needed
                    .clipShape(
                        .rect(
                            topLeadingRadius: 16,
                            bottomLeadingRadius: 16,
                            bottomTrailingRadius: 32,
                            topTrailingRadius: 32
                        )
                    )

                Image(firstPageBackground!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 280)
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
                                    .frame(width: 220, height: 300) // Adjust the frame size as needed
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
                                    .frame(width: 200, height: 280) // Adjust the frame size as needed
                                    .clipShape(
                                        .rect(
                                            topLeadingRadius: 8,
                                            bottomLeadingRadius: 8,
                                            bottomTrailingRadius: 24,
                                            topTrailingRadius: 24
                                        )
                                    )
                            }
                            .overlay(
                                ZStack {
                                    Image("Story/Cover/bookmark")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 70, height: 70)

                                    Text("\(number)")
                                        .customFont(size: 30)
                                        .foregroundColor(Color.brownTxt)
                                        .fontWeight(.bold)
                                        .padding(.bottom, 1)
                                        .offset(x: 0, y: -9)
                                }
                                .position(x: 53, y: 41)
                            )
                        }
                    }
                } background: {} onComplete: {
                    tapHandler?()
                }
                .onTapGesture {
                    peelEffectState = .start
                }
            }
        }
    }
}

#Preview {
    StoryBookNew()
}
