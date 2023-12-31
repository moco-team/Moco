//
//  EpisodeItem.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 10/11/23.
//

import SwiftUI

struct EpisodeItem: View {
    @Environment(\.userViewModel) private var userViewModel
    @Environment(\.episodeViewModel) private var episodeViewModel

    var number = 1
    var fontSize: CGFloat = UIDevice.isIPad ? 55 : 30
    var width = CGFloat(Screen.width * 0.3)
    var height = CGFloat(Screen.height * 0.5)

    var onTap: (() -> Void)?

    var isAvailable: Bool {
        guard let episodes = episodeViewModel.episodes, let userLogin = userViewModel.userLogin else {
            return false
        }

        return episodes[number - 1].isAvailable || number - 1 < userLogin.availableEpisodeSum
    }

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .center) {
                Image(isAvailable ? "Story/episode-list" : "Story/episode-list-locked")
                    .resizable()
                    .scaledToFit()

                if isAvailable {
                    HStack {
                        ZStack {
                            VStack {
                                Text("Bagian")
                                    .customFont(.cherryBomb, size: fontSize - 18)
                                    .foregroundColor(.text.brown)
                                Text("\(number)")
                                    .customFont(.cherryBomb, size: fontSize)
                                    .foregroundColor(.text.brown)
                            }
                            if number < userViewModel.userLogin!.availableEpisodeSum {
                                HStack {
                                    Spacer()
                                    VStack {
                                        Spacer()
                                        Image("Story/done-icon")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: UIDevice.isIPad ? 40 : 20)
                                            .padding()
                                    }
                                }
                            }
                        }
                    }
                    .frame(
                        width: proxy.size.width * (UIDevice.isIPad ? 0.5 : 0.4),
                        height: proxy.size.height * 0.3
                    )
                    .offset(
                        x: proxy.size.width * 0.02,
                        y: proxy.size.height * 0.078
                    )
                }
            }
            .frame(
                width: proxy.size.width,
                height: proxy.size.height,
                alignment: .center
            )
        }.frame(width: width, height: height)
            .onTapGesture {
                onTap?()
            }
    }
}

#Preview {
    EpisodeItem()
        .environment(\.userViewModel, UserViewModel.shared)
        .environment(\.episodeViewModel, EpisodeViewModel.shared)
}
