//
//  StoryViewModel.swift
//  Moco
//
//  Created by Nur Azizah on 16/10/23.
//

import Foundation
import SwiftData

@Observable class StoryViewModel: BaseViewModel {
    static var shared = StoryViewModel()

    var storyPage: StoryModel?

    init(modelContext: ModelContext? = nil) {
        super.init()
        if modelContext != nil {
            self.modelContext = modelContext
        }
    }

    func fetchStory(_ index: Int, _ episode: EpisodeModel?) {
        let episodeUid = episode?.uid

        let fetchDescriptor = FetchDescriptor<StoryModel>(
            predicate: #Predicate {
                $0.episode?.uid == episodeUid
            },
            sortBy: [SortDescriptor<StoryModel>(\.pageNumber)]
        )

        storyPage = (try? modelContext?.fetch(fetchDescriptor)[index] ?? nil) ?? nil
    }

    func getPageBackground(_ index: Int, episode: EpisodeModel?) -> String? {
        let episodeUid = episode?.uid

        let fetchDescriptor = FetchDescriptor<StoryModel>(
            predicate: #Predicate {
                $0.episode?.uid == episodeUid
            },
            sortBy: [SortDescriptor<StoryModel>(\.createdAt)]
        )

        return (try? modelContext?.fetch(fetchDescriptor)[index].background ?? nil) ?? nil
    }

    func getSumMazePrompt(episode: EpisodeModel) -> Int {
        let episodeUid = episode.uid
        let mazeType = PromptType.maze
        let fetchDescriptor = FetchDescriptor<StoryModel>(
            predicate: #Predicate {
                $0.episode?.uid == episodeUid && $0.prompt?.promptType == mazeType
            },
            sortBy: [SortDescriptor<StoryModel>(\.createdAt)]
        )

        let result = (try? modelContext?.fetch(fetchDescriptor) ?? []) ?? []

        return result.count
    }
}
