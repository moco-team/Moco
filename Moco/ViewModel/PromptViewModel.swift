//
//  PromptViewModel.swift
//  Moco
//
//  Created by Nur Azizah on 16/10/23.
//

import Foundation
import SwiftData

@Observable class PromptViewModel: BaseViewModel {
    static var shared = PromptViewModel()
    
    var prompts: [PromptModel]?
    
    init(modelContext: ModelContext? = nil) {
        super.init()
        if modelContext != nil {
            self.modelContext = modelContext
        }
    }
    
    func fetchPrompts(_ story: StoryModel) {
        let storyUid = story.uid
        let fetchDescriptor = FetchDescriptor<PromptModel>(
            predicate: #Predicate {
                $0.story?.uid == storyUid
            },
            sortBy: [SortDescriptor<PromptModel>(\.createdAt)]
        )
        
        prompts = (try? modelContext?.fetch(fetchDescriptor) ?? []) ?? []
    }
}
