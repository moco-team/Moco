//
//  StoryView.swift
//  Moco
//
//  Created by Nur Azizah on 18/10/23.
//

import SwiftUI

struct StoryAdminView: View {
    @Environment(\.navigate) private var navigate
    @Environment(\.storyThemeViewModel) private var storyThemeViewModel
    @Environment(\.storyViewModel) private var storyViewModel
    
    @State var isSheetPresented: Bool = false
    @State private var scrollPosition: Int? = 0
    
    var body: some View {
        ZStack {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach((storyThemeViewModel.selectedStoryTheme?.stories)!, id: \.id) { story in
                        ZStack {
                            Image(story.background)
                                .resizable()
                                .scaledToFill()
                                .frame(width: Screen.width, height: Screen.height, alignment: .center)
                                .clipped()
                        }.id(story.pageNumber-1)
                    }
                }.scrollTargetLayout()
            }.disabled(true)
                .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
                .scrollPosition(id: $scrollPosition)
            ZStack {
                HStack {
                    if scrollPosition! > 0 {
                        StoryNavigationButton(direction: .left) {
                            guard scrollPosition! > 0 else { return }
                            scrollPosition! -= 1
                            storyViewModel.setSelectedStoryPage(scrollPosition!)
                        }
                    }
                    Spacer()
                    StoryNavigationButton(direction: .right) {
                        guard (storyThemeViewModel.selectedStoryTheme?.stories!.count) ?? 0 > scrollPosition! + 1 else {
                            navigate.popToRoot()
                            return
                        }
                        scrollPosition! += 1
                        storyViewModel.setSelectedStoryPage(scrollPosition!)
                    }
                }
            }
        }
        .toolbar {
            Button("Add") {
                isSheetPresented.toggle()
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            StoryModalView(isPresented: $isSheetPresented)
        }
    }
}

#Preview {
    StoryAdminView()
}
