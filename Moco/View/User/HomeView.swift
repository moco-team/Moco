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
    @Environment(\.userViewModel) private var userViewModel
    @Environment(\.navigate) private var navigate

    @State private var homeViewModel = HomeViewModel()

    @State private var isShowing3d = false
    @State private var isMakeSentenceTest = true

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
                            image: "Story/Cover/Story2",
                            firstPageBackground: "Story/Cover/Story2",
                            isLocked: true
                        ) {}
                        StoryBookNew(
                            image: "Story/Cover/Story2",
                            firstPageBackground: "Story/Cover/Story2",
                            isLocked: true
                        ) {}
                        StoryBookNew(
                            image: "Story/Cover/Story2",
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

                // Setiap user punya progress masing-masing dan kalau mau terulang dari episode awal, maka availableEpisodeSum milik user harus direset jumlahnya menjadi 1 (bisa juga dengan cara membuka comment line di bawah ini untuk proses testing saja!)
//                userViewModel.deleteAllUsers()

                userViewModel.fetchUsers()

                if let users = userViewModel.users, users.count > 0 {
                    userViewModel.userLogin = users[0]
                } else {
                    userViewModel.addUser(userData: UserModel(availableStoryThemeSum: 1, availableEpisodeSum: 1))
                    userViewModel.userLogin = userViewModel.users![0]
                }

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
