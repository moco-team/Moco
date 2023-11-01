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
            "Story/Content/Story1/Pages/Page3/background"
        ]

    private let storyBackgroundsTwo: [String] =
        [
            "Story/Content/Story1/Pages/Page4/background",
            "Story/Content/Story1/Pages/Page5/background",
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
                .init(text: "Moco, Bebe, Teka, dan Teki merupakan sahabat yang karib. Moco merupakan seekor anak sapi yang lucu. Bebe adalah seekor anak beruang yang polos. Sedangkan, si kembar teka-teki merupakan dua anak tikus yang buta. Suatu hari, mereka pergi berpetualang bersama.", duration: 2.5, positionX: 0.31, positionY: 0.15, fontSize: 20)
            ],
            [
                .init(text: "Di perjalanannya, dia bertemu dengan teman-temannya yang membutuhkan bantuan.", duration: 5, positionX: 0.31, positionY: 0.18, maxWidth: Screen.width * 0.4)
            ],
            [
                .init(text: "Saat menjelajahi hutan rimba, ", duration: 4, positionX: 0.3, positionY: 0.17, maxWidth: Screen.width * 0.4),
                .init(text: "dia bertemu Maudi si Beruang madu yang sedang menangis.", duration: 5, positionX: 0.3, positionY: 0.17, maxWidth: Screen.width * 0.4),
                .init(text: "Mari kita tanya mengapa Maudi menangis.", duration: 4, positionX: 0.3, positionY: 0.13, maxWidth: Screen.width * 0.4),
                .init(text: "Apa yang sedang dilakukan Maudi?", duration: 2, positionX: 0.3, positionY: 0.13, maxWidth: Screen.width * 0.4)
            ]
        ]

    private let narrativesTwo: [[Narrative]] =
        [
            [
                .init(text: "Ternyata Maudi kehilangan madunya!", duration: 3.5, positionX: 0.5, positionY: 0.3),
                .init(text: "Yuk bantu Maudi mencari madu kesayangannya!", duration: 3.5, positionX: 0.5, positionY: 0.3)
            ],
            [
                .init(text: "Moco melanjutkan petualangannya. \nSaat ingin melewati gua, dia bertemu dengan Teka & Teki si Tikus.", duration: 5, positionX: 0.71, positionY: 0.85)
            ],
            [
                .init(text: "Teka & Teki melarang Moco untuk melewati gua sebelum dia menjawab teka teki yang mereka berikan.", duration: 9, positionX: 0.5, positionY: 0.15),
                .init(text: "Yuk kita selesaikan teka-tekinya!", duration: 2, positionX: 0.5, positionY: 0.15)
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
                .init(text: "Matahari pun terbenam dan Moco merasa lelah. Moco memutuskan untuk beristirahat dan melanjutkan petualangannya esok hari.", duration: 12, positionX: 0.67, positionY: 0.63),
                .init(text: "Hari ini, Moco belajar bahwa petualangan bisa menjadi kesempatan untuk membantu teman-temannya.", duration: 9, positionX: 0.67, positionY: 0.63),
                .init(text: "Moco tidur dengan senyum di wajahnya, bermimpi tentang petualangan berikutnya.", duration: 5, positionX: 0.67, positionY: 0.63)
            ]
        ]

    private let lottieAnimationsOne: [LottieAsset?] =
        [
            .init(fileName: "moco-1-1", positionX: Screen.width * 0.65, positionY: Screen.height * 0.6),
            .init(fileName: "moco-1-2", positionX: Screen.width * 0.54, positionY: Screen.height * 0.6, maxWidth: Screen.width * 0.15),
            .init(fileName: "maudi", positionX: Screen.width * 0.6, positionY: Screen.height * 0.6)
        ]

    private let lottieAnimationsTwo: [LottieAsset?] =
        [
            nil,
            .init(fileName: "moco-1-5", positionX: Screen.width * 0.25, positionY: Screen.height * 0.58, maxWidth: Screen.width * 0.39),
            .init(fileName: "teka_dan_teki", positionX: Screen.width * 0.5, positionY: Screen.height * 0.72, maxWidth: Screen.width * 0.9)
        ]

    private let lottieAnimationsThree: [LottieAsset?] =
        [
            nil,
            .init(fileName: "kakak_katak", positionX: Screen.width * 0.54, positionY: Screen.height * 0.678, maxWidth: Screen.width * 0.35),
            nil,
            .init(fileName: "moco-1-10", positionX: Screen.width * 0.22, positionY: Screen.height * 0.75, maxWidth: Screen.width * 0.35)
        ]

    private let promptsOne: [Prompt?] =
        [
            nil,
            nil,
            .init(type: .speech, startTime: 3)
        ]

    private let promptsTwo: [Prompt?] =
        [
            .init(type: .findHoney, startTime: 3),
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
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .shadow(radius: 4, x: -2, y: 2)
                            .foregroundColor(.white)
                            .onTapGesture {
                                navigate.pop()
                            }

                        Text("Pilih Episode")
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
                                    navigate.append(.story("kol", storyBackgroundsTwo, narrativesTwo, lottieAnimationsTwo, promptsTwo, bgSoundsTwo))
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
