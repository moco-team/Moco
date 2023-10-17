//
//  StoryView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 15/10/23.
//

import SwiftUI

struct StoryView: View {
    @Environment(\.navigate) private var navigate
    @State private var scrollPosition: Int? = 0
    @State private var isPopUpActive = false

    var title: String? = "Hello World"

    private let storyBackgrounds = [
        "Story/Content/Story1/Pages/Page1/background",
        "Story/Content/Story1/Pages/Page2/background"
    ]

    var body: some View {
        ZStack {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(Array(storyBackgrounds.enumerated()), id: \.offset) { index, background in
                        ZStack {
                            Image(background)
                                .resizable()
                                .scaledToFill()
                                .frame(width: Screen.width, height: Screen.height, alignment: .center)
                                .clipped()
                        }.id(index)
                    }
                }.scrollTargetLayout()
            }.disabled(true)
                .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
                .scrollPosition(id: $scrollPosition)
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            isPopUpActive = true
                        } label: {
                            Image(systemName: "xmark").resizable().scaledToFit().padding(20)
                        }.buttonStyle(CircleButton(width: 80, height: 80))
                            .padding()
                    }
                    Spacer()
                }
                HStack {
                    if scrollPosition! > 0 {
                        StoryNavigationButton(direction: .left) {
                            guard scrollPosition! > 0 else { return }
                            scrollPosition! -= 1
                        }
                    }
                    Spacer()
                    StoryNavigationButton(direction: .right) {
                        guard storyBackgrounds.count > scrollPosition! + 1 else {
                            navigate.popToRoot()
                            return
                        }
                        scrollPosition! += 1
                    }
                }
            }
        }
        .popUp(isActive: $isPopUpActive, title: "Are you sure you want to quit?", cancelText: "No") {
            navigate.popToRoot()
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    StoryView()
}
