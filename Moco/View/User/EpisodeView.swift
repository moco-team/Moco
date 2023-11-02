//
//  EpisodeView.swift
//  Moco
//
//  Created by Nur Azizah on 12/10/23.
//

import SwiftData
import SwiftUI

struct EpisodeView: View {
    @Environment(\.episodeViewModel) private var episodeViewModel
    @Environment(\.navigate) private var navigate

    private let storyBackgroundsOne: [String] =
        [
            "Story/Content/Story1/Pages/Page1/background",
            "Story/Content/Story1/Pages/Page2/background",
            "Story/Content/Story1/Pages/Page3/background",
            "Story/Content/Story1/Pages/Page4/background",
            "Story/Content/Story1/Pages/Page5/background"
        ]

    private let storyBackgroundsTwo: [String] =
        [
            "Story/Content/Story1/Pages/Page6/background"
        ]

    private let storyBackgroundsThree: [String] =
        [
            "Story/Content/Story1/Pages/Page7/background",
            "Story/Content/Story1/Pages/Page8/background",
            "Story/Content/Story1/Pages/Page9/background",
            "Story/Content/Story1/Pages/Page10/background"
        ]

    private let narrativesOne: [[Narrative]] =
        [
            [
            ],
            [
            ],
            [
            ],
            [
            ],
            [
            ]
        ]

    private let narrativesTwo: [[Narrative]] =
        [
            [
            ],
            [
            ],
            [
            ],
            [
            ],
            [
            ]
        ]

    private let narrativesThree: [[Narrative]] =
        [
            [
                .init(text: "Aku berkaki empat, tetapi aku tidak bisa berjalan. Orang-orang biasanya duduk di atasku.\nSiapakah aku?", duration: 9, positionX: 0.6, positionY: 0.3)
            ],
            [
                .init(text: "Saat langit sudah mulai gelap, Moco bertemu dengan Kakak Katak yang sedang kesulitan menangkap balon.", duration: 5, positionX: 0.7, positionY: 0.15, color: .white)
            ],
            [
                .init(text: "Kakak Katak sedang mengumpulkan balon yang berwarna Merah. Yuk kita bantu Kakak Katak menangkap balon!", duration: 7, positionX: 0.6, positionY: 0.2, color: .white)
            ],
            [
                .init(
                    text: "Matahari pun terbenam dan Moco merasa lelah." +
                        "Moco memutuskan untuk beristirahat dan melanjutkan petualangannya esok hari.",
                    duration: 12,
                    positionX: 0.67,
                    positionY: 0.63
                ),
                .init(text: "Hari ini, Moco belajar bahwa petualangan bisa menjadi kesempatan untuk membantu teman-temannya.", duration: 9, positionX: 0.67, positionY: 0.63),
                .init(text: "Moco tidur dengan senyum di wajahnya, bermimpi tentang petualangan berikutnya.", duration: 5, positionX: 0.67, positionY: 0.63)
            ]
        ]

    private let lottieAnimationsOne: [LottieAsset?] =
        [
            nil,
            nil,
            nil
        ]

    private let lottieAnimationsTwo: [LottieAsset?] =
        [
            nil,
            nil,
            nil
        ]

    private let lottieAnimationsThree: [LottieAsset?] =
        [
            nil,
            nil,
            nil,
            nil
        ]

    private let promptsOne: [Prompt?] =
        [
            .init(type: .multipleChoice, startTime: 2),
            .init(type: .multipleChoice, startTime: 2),
            .init(type: .multipleChoice, startTime: 2),
            .init(type: .multipleChoice, startTime: 2),
            nil
        ]

    private let promptsTwo: [Prompt?] =
        [
            .init(type: .maze, startTime: 2),
            nil,
            nil
        ]

    private let promptsThree: [Prompt?] =
        [
            .init(type: .objectDetection, startTime: 3),
            nil,
            .init(type: .puzzle, startTime: 3),
            nil
        ]

    private let bgSoundsOne: [String] =
        [
            "bg-story", "bg-story", "bg-story"
        ]

    private let bgSoundsTwo: [String] =
        [
            "bg-story", "bg-story", "bg-story"
        ]

    private let bgSoundsThree: [String] =
        [
            "bg-story", "bg-story", "bg-story", "bg-story"
        ]

    var body: some View {
        ZStack {
            VStack {
                Image("Story/main-background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
            }.frame(width: Screen.width, height: Screen.height)

            VStack {
                HStack(alignment: .center) {
                    Image("Story/nav-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 0.4 * Screen.width)
                        .padding(.top, 50)

                    Spacer()

                    BurgerMenu()
                }
                .padding(.horizontal, 0.05 * Screen.width)

                Spacer()

                HStack {
                    HStack(spacing: 40) {
                        Image("Buttons/button-home")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .shadow(radius: 4, x: -2, y: 2)
                            .foregroundColor(.white)
                            .onTapGesture {
                                navigate.pop()
                            }

                        Text("Chapters")
                            .customFont(.cherryBomb, size: 50)
                            .foregroundColor(Color.blueTxt)
                            .fontWeight(.bold)
                    }

                    Spacer()
                }.padding(.leading, 60).padding(.bottom, 30)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [GridItem(.flexible())]) {
                        ForEach(0 ..< episodeViewModel.episodeActive.count, id: \.self) { index in
                            StoryBookNew(
                                title: "title",
                                image: "chevron.left",
                                firstPageBackground: "chevron.right",
                                number: index + 1
                            ) {
                                if index == 0 {
                                    navigate.append(.story("kol", storyBackgroundsOne, narrativesOne, lottieAnimationsOne, promptsOne, bgSoundsOne))
                                } else if index == 1 {
                                    navigate.append(.arStory)
                                } else if index == 2 {
                                    navigate.append(.story("kol", storyBackgroundsThree, narrativesThree, lottieAnimationsThree, promptsThree, bgSoundsThree))
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                }.scrollClipDisabled()

                Spacer()
                Spacer()
            }
        }
    }
}

#Preview {
    @State var itemViewModel = ItemViewModel()

    return EpisodeView().environment(\.itemViewModel, itemViewModel)
}
