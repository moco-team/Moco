//
//  StoryThemeAdminView.swift
//  Moco
//
//  Created by Nur Azizah on 18/10/23.
//

import SwiftUI

struct StoryThemeAdminView: View {
    @Environment(\.navigate) private var navigate
    @Environment(\.storyThemeViewModel) private var storyThemeViewModel
    @Environment(\.storyViewModel) private var storyViewModel
    @Environment(\.storyContentViewModel) private var storyContentViewModel
    
    @State var isSheetPresented: Bool = false
    
    func deleteStoryTheme(_ storyTheme: StoryThemeModel) {
        storyThemeViewModel.deleteStoryTheme(storyTheme: storyTheme)
    }
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.flexible())]) {
                    ForEach(Array(storyThemeViewModel.storyThemes.enumerated()), id: \.1) { index, storyTheme in
                        VStack {
                            VStack {
                                Text(storyTheme.descriptionTheme)
                                Image(storyTheme.pictureName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 300, height: 400, alignment: .center)
                                    .clipped()
                            }.padding()
                            
                            Button(action: {
                                deleteStoryTheme(storyTheme)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }.padding()
                            .onTapGesture {
                                storyThemeViewModel.setSelectedStoryTheme(index)
                                
                                storyViewModel.fetchStories(storyThemeViewModel.selectedStoryTheme)
                                
                                if storyViewModel.stories.count > 0 {
                                    storyViewModel.setSelectedStoryPage(0)
                                    
                                    storyContentViewModel.fetchStoryContents(storyViewModel.selectedStoryPage!)
                                }
                                
                                navigate.append(.storyAdmin("storyAdmin"))
                            }
                    }
                }
                .padding(.horizontal, 30)
                .toolbar {
                    Button("Add") {
                        isSheetPresented.toggle()
                    }
                }
                .sheet(isPresented: $isSheetPresented) {
                    StoryThemeModalAdminView(isPresented: $isSheetPresented)
                }
            }.scrollClipDisabled()
        }.navigationTitle("Story Theme")
    }
}

#Preview {
    @State var storyThemeViewModel = StoryThemeViewModel()
    
    return StoryThemeAdminView().environment(\.storyThemeViewModel, storyThemeViewModel)
}
