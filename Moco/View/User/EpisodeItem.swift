//
//  EpisodeItem.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 10/11/23.
//

import SwiftUI

struct EpisodeItem: View {
    var number = 1
    var fontSize = CGFloat(34)
    var width = CGFloat(330)
    var height = CGFloat(440)

    var onTap: (() -> Void)?

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .center) {
                Image("Story/episode-list")
                    .resizable()
                    .scaledToFit()

                HStack {
                    Text("\(number)")
                        .customFont(.cherryBomb, size: fontSize)
                        .foregroundColor(.text.brown)
                }
                .frame(
                    width: proxy.size.width * 0.5,
                    height: proxy.size.height * 0.3
                )
                .offset(
                    x: proxy.size.width * 0.02,
                    y: proxy.size.height * 0.07
                )
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
}
