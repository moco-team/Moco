//
//  EpisodeViewModel.swift
//  Moco
//
//  Created by Nur Azizah on 31/10/23.
//

import Foundation
import SwiftData

@Observable class EpisodeViewModel: BaseViewModel {
    //    var episodes = [EpisodeModel]()
    var episodeActive: [Int] = [1]
    
    
    func appendEpisodeActive(_ indexEpisode: Int) {
        if episodeActive.count < 3 {
            self.episodeActive.append(indexEpisode)
        }
    }
    //    init(modelContext: ModelContext? = nil) {
    //        super.init()
    //        if modelContext != nil {
    //            self.modelContext = modelContext
    //        }
    //        if self.modelContext != nil {
    //            fetchHints(nil)
    //        }
    //    }
    //
    //    func fetchHints(_ prompt: PromptModel?) {
    //        // ???: Cannot assign to predicate without putting it into variable first, idk why
    //        let promptId = prompt?.id
    //        let fetchDescriptor = FetchDescriptor<HintModel>(
    //            predicate: #Predicate {
    //                $0.prompt?.id == promptId
    //            },
    //            sortBy: [SortDescriptor<HintModel>(\.createdAt)]
    //        )
    //
    //        hints = (try? modelContext?.fetch(fetchDescriptor) ?? []) ?? []
    //    }
    //
    //    func createHint(_ prompt: PromptModel) {
    //        let newHint = HintModel(hint: "new hint")
    //        newHint.prompt = prompt
    //
    //        modelContext?.insert(newHint)
    //        try? modelContext?.save()
    //
    //        fetchHints(prompt)
    //    }
    //
    //    func deleteHint(prompt: PromptModel, hint: HintModel) {
    //        modelContext?.delete(hint)
    //        try? modelContext?.save()
    //
    //        fetchHints(prompt)
    //    }
    //
    //    func deleteHint(prompt: PromptModel, index: Int) {
    //        guard hints.indices.contains(index) else { return }
    //        modelContext?.delete(hints[index])
    //        try? modelContext?.save()
    //
    //        fetchHints(prompt)
    //    }
}
