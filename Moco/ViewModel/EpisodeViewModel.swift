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
    var availableEpisodes: [EpisodeModel]?
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
        
        availableEpisodes = []
        
        for episode in episodes ?? [] {
            if episode.isAvailable {
                availableEpisodes?.append(episode)
            }
        }
    }
    
    func setToAvailable(selectedStoryTheme: StoryThemeModel) {
        if let episodes = episodes, let availableEpisodes = availableEpisodes {
            if availableEpisodes.count < episodes.count &&
                selectedEpisode!.uid == availableEpisodes[availableEpisodes.count - 1].uid {
                let storyThemeId = selectedStoryTheme.uid
                let fetchDescriptor = FetchDescriptor<EpisodeModel>(
                    predicate: #Predicate {
                        $0.storyTheme?.uid == storyThemeId
                    },
                    sortBy: [SortDescriptor<EpisodeModel>(\.createdAt)]
                )
                
                if let getEpisodes = (try? modelContext?.fetch(fetchDescriptor)) {
                    getEpisodes[availableEpisodes.count].isAvailable = true
                    try? modelContext?.save()
                }
            }
        }
    }
    
    func getPromptByType(promptType: PromptType) -> [StoryModel] {
        let result = selectedEpisode?.stories?.filter {
            $0.prompt?.promptType == promptType
        }.sorted { lhs, rhs in lhs.pageNumber < rhs.pageNumber } ?? []
        
        return result
    }
    
    func getMazeProgress(promptId: String) -> (Double, Int, Int) {
        let mazePrompts = getPromptByType(promptType: .maze)
        guard mazePrompts.count > 0 else { return (0, 0, 0) }
        let nthPrompt = Double((mazePrompts.firstIndex {
            $0.prompt?.uid == promptId
        } ?? 0))
        return (nthPrompt / Double(mazePrompts.count),
                Int(nthPrompt), mazePrompts.count)
    }
}
