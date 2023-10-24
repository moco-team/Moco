//
//  StoryThemeViewModel.swift
//  Moco
//
//  Created by Nur Azizah on 16/10/23.
//

import Foundation
import SwiftData

@Observable class StoryThemeViewModel: BaseViewModel {
    var storyThemes = [StoryThemeModel]()
    var selectedStoryTheme: StoryThemeModel?

    init(modelContext: ModelContext? = nil) {
        super.init()
        if modelContext != nil {
            self.modelContext = modelContext
        }
    }

    func fetchStoryThemes() {
        let fetchDescriptor = FetchDescriptor<StoryThemeModel>(
            sortBy: [SortDescriptor<StoryThemeModel>(\.createdAt)]
        )

        storyThemes = (try? modelContext?.fetch(fetchDescriptor) ?? []) ?? []
    }

    func createStoryTheme(stories: [StoryModel], pictureName: String, descriptionTheme: String) {
        let newStoryTheme = StoryThemeModel(pictureName: pictureName, descriptionTheme: descriptionTheme)
        newStoryTheme.stories = stories

        modelContext?.insert(newStoryTheme)
        try? modelContext?.save()

        fetchStoryThemes()
    }

    func deleteStoryTheme(storyTheme: StoryThemeModel) {
        modelContext?.delete(storyTheme)
        try? modelContext?.save()

        fetchStoryThemes()
    }

    func deleteStoryTheme(_ index: Int) {
        guard storyThemes.indices.contains(index) else { return }
        modelContext?.delete(storyThemes[index])
        try? modelContext?.save()

        fetchStoryThemes()
    }

    func setSelectedStoryTheme(_ index: Int) {
        guard storyThemes.indices.contains(index) else { return }
        selectedStoryTheme = storyThemes[index]
    }
}
