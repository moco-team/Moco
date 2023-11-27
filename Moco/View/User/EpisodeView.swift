//
//  EpisodeView.swift
//  Moco
//
//  Created by Nur Azizah on 12/10/23.
//

import SwiftData
import SwiftUI

struct EpisodeView: View {
    @Environment(\.audioViewModel) private var audioViewModel
    @Environment(\.storyThemeViewModel) private var storyThemeViewModel
    @Environment(\.userViewModel) private var userViewModel
    @Environment(\.episodeViewModel) private var episodeViewModel
    @Environment(\.storyViewModel) private var storyViewModel
    @Environment(\.storyContentViewModel) private var storyContentViewModel
    @Environment(\.promptViewModel) private var promptViewModel
    @Environment(\.hintViewModel) private var hintViewModel
    @Environment(\.navigate) private var navigate

    var homeButtonSize: CGFloat {
        UIDevice.isIPad ? 70 : 50
    }

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
                    MocoIcon()

                    Spacer()

                    BurgerMenu()
                }
                .padding(.horizontal, 0.05 * Screen.width)

                HStack {
                    HStack(spacing: 40) {
                        Image("Buttons/button-home")
                            .resizable()
                            .frame(width: homeButtonSize, height: homeButtonSize)
                            .shadow(radius: 4, x: -2, y: 2)
                            .foregroundColor(.white)
                            .onTapGesture {
                                navigate.pop()
                            }

                        Text("Episode")
                            .customFont(.cherryBomb, size: UIDevice.isIPad ? 50 : 30)
                            .foregroundColor(Color.blueTxt)
                            .fontWeight(.bold)
                    }

                    Spacer()
                }.padding(.leading, 60)
                    .padding(.vertical, Screen.height * 0.1)

                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [GridItem(.flexible())]) {
                        if let episodes = episodeViewModel.episodes {
                            ForEach(
                                Array(episodes.enumerated()), id: \.element
                            ) { index, episode in
                                EpisodeItem(
                                    number: index + 1
                                ) {
                                    if episode.isAvailable || index < userViewModel.userLogin!.availableEpisodeSum {
                                        Task {
                                            episodeViewModel.setSelectedEpisode(episode)

                                            // open new story page
                                            storyViewModel.fetchStory(0, episodeViewModel.selectedEpisode!)
                                            storyContentViewModel.fetchStoryContents(storyViewModel.storyPage!)

                                            if storyViewModel.storyPage!.isHavePrompt {
                                                promptViewModel.fetchPrompts(storyViewModel.storyPage!)

                                                if promptViewModel.prompts![0].hints != nil {
                                                    hintViewModel.fetchHints(promptViewModel.prompts![0])
                                                }
                                            }

                                            navigate.append(.story)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, UIDevice.isIPad ? 30 : 10)
                }.scrollClipDisabled()

                Spacer()
            }
        }
        .task {
            episodeViewModel.fetchEpisodes(storyThemeId: storyThemeViewModel.selectedStoryTheme!.uid)
            if navigate.previousRoute == .story {
                audioViewModel.clearAll()
                audioViewModel.playSound(soundFileName: "bg-shop", numberOfLoops: -1, category: .backsound)
            }
            AppDelegate.orientationLock = nil
        }
    }
}

#Preview {
    EpisodeView()
}
