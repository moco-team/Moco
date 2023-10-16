//
//  StoryViewModel.swift
//  Moco
//
//  Created by Nur Azizah on 16/10/23.
//

import Foundation
import SwiftData

@Observable class StoryViewModel: BaseViewModel {
    var stories = [StoryModel]()
    
    init(modelContext: ModelContext? = nil, repository: ItemRepository) {
        super.init()
        self.repository = repository
    }
        
//    init(modelContext: ModelContext? = nil) {
//        super.init()
//        if modelContext != nil {
//            self.modelContext = modelContext
//        }
//        if self.modelContext != nil {
//            fetchStories(nil)
//        }
//    }
//    
//    func fetchStories(_ storyThemeModel: StoryThemeModel?) {
//        let fetchDescriptor = FetchDescriptor<StoryModel>(
//            predicate: #Predicate {
//                $0.storyTheme?.id == storyThemeModel?.id
//            },
//            sortBy: [SortDescriptor<StoryModel>(\.pageNumber)]
//        )
//        
//        stories = (try? modelContext?.fetch(fetchDescriptor) ?? []) ?? []
//    }
//    
//    func createStory(storyTheme: StoryThemeModel) {
//        let newStory = StoryModel(background: "bg", pageNumber: 1, is_have_prompt: false)
//        newStory.storyTheme = storyTheme
//        
//        modelContext?.insert(newStory)
//        try? modelContext?.save()
//        
//        fetchStories(storyTheme)
//    }
//    
//    func deleteStory(_ story: StoryModel, _ storyTheme: StoryThemeModel) {
//        modelContext?.delete(story)
//        try? modelContext?.save()
//        
//        fetchStories(storyTheme)
//    }
//    
//    func deleteStory(index: Int, _ storyTheme: StoryThemeModel) {
//        guard stories.indices.contains(index) else { return }
//        modelContext?.delete(stories[index])
//        try? modelContext?.save()
//        
//        fetchStories(storyTheme)
//    }
}
