//
//  StoryThemeViewModel.swift
//  Moco
//
//  Created by Nur Azizah on 16/10/23.
//

import Foundation
import SwiftData

@Observable class StoryThemeViewModel: BaseViewModel {
    static var shared = StoryThemeViewModel()

    var storyThemes: [StoryThemeModel]?
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

    func setSelectedStoryTheme(_ storyTheme: StoryThemeModel) {
        selectedStoryTheme = storyTheme
    }

    func deleteAllStoryThemes() {
        for storyTheme in storyThemes ?? [] {
            modelContext?.delete(storyTheme)
            try? modelContext?.save()
        }
        fetchStoryThemes()
    }

    func findWithID(_: String) -> StoryThemeModel? {
        for storyTheme in storyThemes ?? [] {
            if storyTheme.uid == storyTheme.uid {
                return storyTheme
            }
        }

        return nil
    }
}
