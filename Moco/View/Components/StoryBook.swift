//
//  StoryBook.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 14/10/23.
//

import MediaPlayer
import SwiftUI

struct StoryBook: View {
    // MARK: - Stored variable definition

    @Environment(\.font) private var font

    var title: String = "Story 1"
    let durationAndDelay: CGFloat = 0.3
    var image: String? = "Story/Cover/Story1"
    var firstPageBackground: String?
    var number: Int = 1
    @State var degree = 0.0
    @State var isFlipped = false

    var tapHandler: (() -> Void)?

    // MARK: - Flip Card Function

    func flipCard() {
        isFlipped.toggle()
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
                degree = -90
            } completion: {
                tapHandler?()
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                degree = 0
            }
        }
    }

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

//                Image("Story/Content/Story1/Pages/Page1/background")
                Image(firstPageBackground!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 220, height: 280)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 8,
                            bottomLeadingRadius: 8,
                            bottomTrailingRadius: 24,
                            topTrailingRadius: 24
                        )
                    )
                    .shadow(color: .black.opacity(0.12), radius: 5, x: 15, y: 8)
                    .shadow(color: .black.opacity(0.1), radius: 6, x: -10, y: -8)

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
                .onAppear {
                    print(firstPageBackground!)
                }
                .padding()
                .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0), anchor: .leading, perspective: 0.5)
                .onTapGesture {
                    flipCard()
                }
            }
        }.padding()
            .onAppear {
                isFlipped = false
                degree = 0.0
            }
    }
}

#Preview {
    StoryBook()
}
