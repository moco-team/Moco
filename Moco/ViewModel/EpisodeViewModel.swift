//
//  EpisodeViewModel.swift
//  Moco
//
//  Created by Nur Azizah on 31/10/23.
//

import Foundation
import SwiftData

@Observable class EpisodeViewModel: BaseViewModel {
    static let shared = EpisodeViewModel()

    var selectedEpisode: EpisodeModel?
    var episodes: [EpisodeModel]?

    init(modelContext: ModelContext? = nil) {
        super.init()
        if modelContext != nil {
            self.modelContext = modelContext
        }
    }

    func setSelectedEpisode(_ episode: EpisodeModel) {
        selectedEpisode = episode
    }

    func fetchEpisodes(storyThemeId: String) {
        let fetchDescriptor = FetchDescriptor<EpisodeModel>(
            predicate: #Predicate {
                $0.storyTheme?.uid == storyThemeId
            },
            sortBy: [SortDescriptor<EpisodeModel>(\.createdAt)]
        )

        episodes = (try? modelContext?.fetch(fetchDescriptor) ?? []) ?? []
    }

    func fetchAvailableEpisodes(storyThemeId: String) -> [EpisodeModel]? {
        let fetchDescriptor = FetchDescriptor<EpisodeModel>(
            predicate: #Predicate {
                $0.storyTheme?.uid == storyThemeId && $0.isAvailable == true
            },
            sortBy: [SortDescriptor<EpisodeModel>(\.createdAt)]
        )

        return (try? modelContext?.fetch(fetchDescriptor) ?? []) ?? []
    }

    func setToAvailable(selectedStoryTheme: StoryThemeModel) {
        fetchEpisodes(storyThemeId: selectedStoryTheme.uid)

        if let availableEpisode = fetchAvailableEpisodes(storyThemeId: selectedStoryTheme.uid) {
            episodes![availableEpisode.count].isAvailable = true
            try? modelContext?.save()
        }
    }

    func getPromptByType(promptType: PromptType) -> [PromptModel] {
        let result = selectedEpisode?.stories?
            .sorted {
                lhs, rhs in lhs.pageNumber < rhs.pageNumber
            }
            .compactMap { $0.prompts }
            .flatMap { $0 }
            .filter {
                $0.promptType == promptType
            } ?? []

        return result
    }

    func getMazeProgress(promptId: String) -> (Double, Int, Int) {
        let mazePrompts = getPromptByType(promptType: .maze)
        guard mazePrompts.count > 0 else { return (0, 0, 0) }
        let nthPrompt = Double((mazePrompts.firstIndex {
            $0.uid == promptId
        } ?? 0))
        return (nthPrompt / Double(mazePrompts.count),
                Int(nthPrompt), mazePrompts.count)
    }
}
