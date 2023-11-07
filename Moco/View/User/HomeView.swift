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
                        .padding(.top, 50)

                    Spacer()

                    BurgerMenu()
                }
                .padding(.horizontal, 0.05 * Screen.width)

                Spacer()

                HStack {
                    Text("Koleksi Buku")
                        .customFont(.cherryBomb, size: 50)
                        .foregroundColor(Color.blueTxt)
                        .fontWeight(.bold)
                    Spacer()
                }.padding(.leading, 60).padding(.bottom, 30)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [GridItem(.flexible())]) {
                        if let storyThemes = storyThemeViewModel.storyThemes {
                            ForEach(
                                Array(storyThemes.enumerated()), id: \.element
                            ) { index, storyTheme in
                                StoryBookNew(
                                    image: storyTheme.pictureName,
                                    firstPageBackground: storyTheme.episodes![0].pictureName,
                                    number: index + 1
                                ) {
                                    storyThemeViewModel.setSelectedStoryTheme(storyTheme)

                                    navigate.append(.episode)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                }.scrollClipDisabled()

                Spacer()
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
        }
    }
}

#Preview {
    HomeView()
}
