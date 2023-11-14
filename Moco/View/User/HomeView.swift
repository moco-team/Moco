//
//  HomeView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 11/10/23.
//

import MediaPlayer
import SwiftData
import SwiftUI

struct HomeView: View {
    @Environment(\.audioViewModel) private var audioViewModel
    @Environment(\.timerViewModel) private var timerViewModel

    @Environment(\.storyThemeViewModel) private var storyThemeViewModel
    @Environment(\.navigate) private var navigate

    @State private var homeViewModel = HomeViewModel()

    @State private var isShowing3d = false

    var body: some View {
        ZStack {
            VStack {
                Image("Story/main-background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
            }.frame(width: Screen.width, height: Screen.height)

            VStack {
                HStack(alignment: .center) {
                    Image("Story/nav-icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 0.4 * Screen.width)
                        .padding(.top, Screen.height * 0.02)

                    Spacer()

                    BurgerMenu()
                }
                .padding(.horizontal, 0.05 * Screen.width)

                HStack {
                    Text("Koleksi Cerita Dunia Ajaib")
                        .customFont(.cherryBomb, size: 50)
                        .foregroundColor(Color.blueTxt)
                        .fontWeight(.bold)

                    NavigationLink(destination: QRScannerSheet()) {
                        Text("QR Code")
                    }
                    Button("Test 3d") {
                        self.isShowing3d = true
                    }
                    NavigationLink(
                        destination: ARTutorialView {
                            navigate.pop()
                        }
                    ) {
                        Text("AR Tutorial")
                    }
                    NavigationLink(
                        destination: ARStory(
                            prompt: PromptModel(
                                correctAnswer: "honey_jar", // object to be found
                                startTime: 0,
                                promptType: PromptType.ar,
                                hints: nil,
                                question: "Wow! kita sudah berada di pulau Arjuna. Sekarang, cari madu agar bisa menemukan Maudi!",
                                answerAssets: ["honey_jar"] // meshes
                            ),
                            lastPrompt: true
                        ) {
                            navigate.pop()
                        }
                    ) {
                        Text("AR Story")
                    }
                    Spacer()
                }.padding(.leading, 60)
                    .padding(.vertical, Screen.height * 0.1)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [GridItem(.flexible())]) {
                        if let storyThemes = storyThemeViewModel.storyThemes {
                            ForEach(
                                Array(storyThemes.enumerated()), id: \.element
                            ) { index, storyTheme in
                                StoryBookNew(
                                    image: storyTheme.pictureName,
                                    firstPageBackground: storyTheme.episodes?.first?.pictureName ?? "",
                                    number: index + 1
                                ) {
                                    storyThemeViewModel.setSelectedStoryTheme(storyTheme)

                                    navigate.append(.episode)
                                }
                            }
                        }
                        StoryBookNew(
                            firstPageBackground: "Story/Cover/Story2",
                            isLocked: true
                        ) {}
                    }
                    .padding(.horizontal, 30)
                }.scrollClipDisabled()

                Spacer()
            }
            .onShake {
                //                navigate.append(.storyThemeAdmin)
            }
            .onAppear {
                storyThemeViewModel.fetchStoryThemes()
                if navigate.previousRoute == nil {
                    audioViewModel.clearAll()
                    audioViewModel.playSound(soundFileName: "bg-shop", numberOfLoops: -1, category: .backsound)
                }
                homeViewModel.soundLevel = 0.3
                homeViewModel.setVolume()
            }
            if isShowing3d {
                ThreeDRenderer {
                    print("test 3d render selesai!")
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
