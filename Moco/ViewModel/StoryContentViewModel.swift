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
            //            predicate: #Predicate { storyContent in
            //fill in...
            //            },
            sortBy: [SortDescriptor<StoryContentModel>(\.createdAt)]
        )
        
        storyContents = (try? modelContext?.fetch(fetchDescriptor) ?? []) ?? []
    }
    
    func createStoryContent(stories: [StoryModel], story: StoryModel) {
        let newStoryContent = StoryContentModel(duration: 9.0, contentName: "audio.mp3", contentType: "audio")
        newStoryContent.stories = stories
        
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
}
