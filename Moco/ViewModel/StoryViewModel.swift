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
            sortBy: [SortDescriptor<StoryModel>(\.createdAt)]
        )

        storyPage = (try? modelContext?.fetch(fetchDescriptor)[index] ?? nil) ?? nil
    }

    func getSumMazePrompt(episode: EpisodeModel) -> Int {
        let episodeUid = episode.uid
        let fetchDescriptor = FetchDescriptor<StoryModel>(
            predicate: #Predicate {
                $0.episode?.uid == episodeUid
            },
            sortBy: [SortDescriptor<StoryModel>(\.createdAt)]
        )

        let getMazes = (try? modelContext?.fetch(fetchDescriptor) ?? nil) ?? nil

        var sumMazePrompts = 0
        for promptType in getMazes ?? [] {
            if promptType.prompt!.promptType == PromptType.maze {
                sumMazePrompts += 1
            }
        }

        return sumMazePrompts
    }
}
