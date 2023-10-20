//
//  StoryAdminView.swift
//  Moco
//
//  Created by Nur Azizah on 18/10/23.
//

import SwiftUI

struct StoryAdminView: View {
    @Environment(\.navigate) private var navigate
    @Environment(\.storyThemeViewModel) private var storyThemeViewModel
    @Environment(\.storyViewModel) private var storyViewModel
    @Environment(\.promptViewModel) private var promptViewModel
    @Environment(\.storyContentViewModel) private var storyContentViewModel
    
    @State var isSheetPresented: Bool = false
    @State var isSheetPromptPresented: Bool = false
    @State private var scrollPosition: Int? = 0
    
    var body: some View {
        ZStack {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(storyViewModel.stories, id: \.id) { story in
                        ZStack {
                            Image(story.background)
                                .resizable()
                                .scaledToFill()
                                .frame(width: Screen.width, height: Screen.height, alignment: .center)
                                .clipped()
                            
                            Text(storyContentViewModel.getTextStoryContent((storyViewModel.selectedStoryPage!)) ?? "")
                        }.id(story.pageNumber - 1)
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
                            
                            storyContentViewModel.fetchStoryContents(storyViewModel.selectedStoryPage!)
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
                        
                        storyContentViewModel.fetchStoryContents(storyViewModel.selectedStoryPage!)
                    }
                }
            }
        }
        .toolbar {
            HStack {
                Button("Add") {
                    isSheetPresented.toggle()
                }
                
                if storyViewModel.stories.count > 0 {
                    Button("Delete") {
                        storyViewModel.deleteStory(storyViewModel.selectedStoryPage!, storyThemeViewModel.selectedStoryTheme!)
                        
                        scrollPosition! -= 1
                        storyViewModel.setSelectedStoryPage(scrollPosition!)
                        
                        storyContentViewModel.fetchStoryContents(storyViewModel.selectedStoryPage!)
                    }
                    
                    if storyViewModel.selectedStoryPage!.isHavePrompt {
                        Button("Prompt") {
                            promptViewModel.fetchPrompts(storyViewModel.selectedStoryPage)
                            isSheetPromptPresented.toggle()
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            StoryModalAdminView(isPresented: $isSheetPresented)
        }
        .sheet(isPresented: $isSheetPromptPresented) {
            PromptModalAdminView(isPromptPresented: $isSheetPromptPresented)
        }
    }
}

#Preview {
    StoryAdminView()
}
