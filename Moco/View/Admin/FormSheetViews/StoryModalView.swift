//
//  StoryModalView.swift
//  Moco
//
//  Created by Nur Azizah on 18/10/23.
//

import SwiftUI

struct StoryModalView: View {
    @Environment(\.storyViewModel) private var storyViewModel
    @Environment(\.storyThemeViewModel) private var storyThemeViewModel
    @Environment(\.storyContentViewModel) private var storyContentViewModel
    
    let contentTypeOptions = ["Text", "Animated", "Sound Background", "Storytelling Audio"]
    let isHavePromptOptions = [0, 1]
    
    @Binding var isPresented: Bool
    @State private var background: String = ""
    @State private var pageNumber: String = ""
    @State private var isHavePrompt: Int = 0
    
    @State private var duration: String = ""
    @State private var contentName: String = ""
    @State private var contentType: String = ""
    @State private var selectedStoryPage: StoryModel?
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Add Story for page \(storyViewModel.stories.count+1)")) {
                    TextField("Background name...", text: $background)
                    
                    VStack {
                        Text("Is It Prompt?")
                        Picker("Is It Prompt...", selection: $isHavePrompt) {
                            ForEach(0..<isHavePromptOptions.count, id: \.self) { index in
                                Text(String(isHavePromptOptions[index]) ).tag(index)
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                }
                
                if storyViewModel.stories.count > 0 {
                    Divider()
                        .frame(height: 2)
                        .padding(.horizontal)
                    
                    Section(header: Text("Add Story Content in One Page")) {
                        VStack {
                            Text("Choose Story Page")
                            Picker("Choose Story Page", selection: $selectedStoryPage) {
                                ForEach(0..<storyViewModel.stories.count, id: \.self) { index in
                                    Text(String(storyViewModel.stories[index].pageNumber) ).tag(index)
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                        
                        TextField("Duration...", text: $duration)
                        
                        TextField("Content Name...", text: $contentName)
                        
                        VStack {
                            Text("Content Type")
                            Picker("Content Type", selection: $contentType) {
                                ForEach(0..<contentTypeOptions.count, id: \.self) { index in
                                    Text(contentTypeOptions[index]).tag(index)
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                    }
                }
            }
            .navigationBarItems(
                leading:
                    Button("Cancel") {
                        isPresented = false
                    },
                trailing:
                    HStack {
                        Button("Add Story Theme") {
                            storyViewModel.createStory(storyTheme: storyThemeViewModel.selectedStoryTheme!, background: background, pageNumber: storyViewModel.stories.count+1, isHavePrompt: (isHavePrompt != 0))
                            isPresented = false
                        }
                        
                        Button("Add Story Content Theme") {
                            storyContentViewModel.createStoryContent(story: selectedStoryPage!, duration: Double(duration)!, contentName: contentName, contentType: contentType)
                            isPresented = false
                        }
                    }
            )
            .navigationTitle("Modal Sheet Form")
        }
    }
}

#Preview {
    StoryModalView(isPresented: .constant(true))
}
