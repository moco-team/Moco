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

    init(modelContext: ModelContext? = nil) {
        super.init()
        if modelContext != nil {
            self.modelContext = modelContext
        }
        if self.modelContext != nil {
            fetchStoryThemes()
        }
    }

    func fetchStoryThemes() {
        let fetchDescriptor = FetchDescriptor<StoryThemeModel>(
            sortBy: [SortDescriptor<StoryThemeModel>(\.createdAt)]
        )

        storyThemes = (try? modelContext?.fetch(fetchDescriptor) ?? []) ?? []
    }

    func createStoryTheme(stories: [StoryModel]) {
        let newStoryTheme = StoryThemeModel(pictureName: "picture", descriptionTheme: "new")
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
}
