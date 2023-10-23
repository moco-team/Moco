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
                    Text("Koleksi Buku")
                        .customFont(.cherryBomb, size: 50)
                        .foregroundColor(Color.blueTxt)
                        .fontWeight(.bold)
                    Spacer()
                }.padding(.leading, 60).padding(.bottom, 30)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [GridItem(.flexible())]) {
                        ForEach(
                            Array(storyThemeViewModel.storyThemes.enumerated()), id: \.element
                        ) { index, storyTheme in
                            StoryBook(
                                title: storyTheme.title,
                                image: storyTheme.pictureName,
                                number: index + 1
                            ) {
                                navigate.append(.story(storyTheme.id))
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                }.scrollClipDisabled()

                Spacer()
                Spacer()
            }
            .onShake {
                navigate.append(.storyThemeAdmin)
            }
            .onAppear {
                storyThemeViewModel.fetchStoryThemes()
                audioViewModel.playSound(soundFileName: "bg-shop", numberOfLoops: -1)
                homeViewModel.soundLevel = 0.3
                homeViewModel.setVolume()
            }
        }
    }
}

#Preview {
    @State var itemViewModel = ItemViewModel()

    return HomeView().environment(\.itemViewModel, itemViewModel)
}
