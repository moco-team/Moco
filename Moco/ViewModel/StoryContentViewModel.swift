//
//  StoryContentViewModel.swift
//  Moco
//
//  Created by Nur Azizah on 16/10/23.
//

import Foundation
import SwiftData

@Observable class StoryContentViewModel: BaseViewModel {
    var storyContents = [StoryContentModel]()
    var selectedStoryContents = [StoryContentModel]()
    
    init(modelContext: ModelContext? = nil) {
        super.init()
        if modelContext != nil {
            self.modelContext = modelContext
        }
        if self.modelContext != nil {
            fetchStoryContents(nil)
        }
    }

    func fetchStoryContents(_ story: StoryModel?) {
        let fetchDescriptor = FetchDescriptor<StoryContentModel>(
            sortBy: [SortDescriptor<StoryContentModel>(\.createdAt)]
        )
        
        storyContents = (try? modelContext?.fetch(fetchDescriptor) ?? []) ?? []
        
        getStoryContentPage(story)
    }

    func createStoryContent(story: StoryModel, duration: TimeInterval, contentName: String, contentType: String) {
        let newStoryContent = StoryContentModel(duration: duration, contentName: contentName, contentType: contentType)
        newStoryContent.stories?.append(story)

        modelContext?.insert(newStoryContent)
        try? modelContext?.save()

        fetchStoryContents(story)
    }

    func deleteStoryContent(story: StoryModel, storyContent: StoryContentModel) {
        modelContext?.delete(storyContent)
        try? modelContext?.save()

        fetchStoryContents(story)
    }

    func deleteStoryContent(index: Int, story: StoryModel) {
        guard storyContents.indices.contains(index) else { return }
        modelContext?.delete(storyContents[index])
        try? modelContext?.save()

        fetchStoryContents(story)
    }
    
    func getStoryContentPage(_ story: StoryModel?) {
        self.selectedStoryContents = []
        
        if let story = story {
            for storyContent in storyContents {
                for storyObj in storyContent.stories! {
                    if storyObj.id == story.id {
                        self.selectedStoryContents.append(storyContent)
                    }
                }
            }
        }
    }
    
    func getTextStoryContent(_ story: StoryModel) -> String? {
        for storyContent in selectedStoryContents {
            if storyContent.contentType == "Text" {
                    return storyContent.contentName
            }
        }
        return nil
    }
}
