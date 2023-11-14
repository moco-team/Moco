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

    var prompt: PromptModel?
    var promptScan: [PromptModel]?

    init(modelContext: ModelContext? = nil) {
        super.init()
        if modelContext != nil {
            self.modelContext = modelContext
        }
    }

    func fetchPrompt(_ story: StoryModel, _ earlyPrompt: Bool) {
        let storyUid = story.uid
        
        if earlyPrompt {
            let fetchDescriptor = FetchDescriptor<PromptModel>(
                predicate: #Predicate {
                    $0.story?.uid == storyUid
                },
                sortBy: [SortDescriptor<PromptModel>(\.createdAt)]
            )
            
            promptScan = (try? modelContext?.fetch(fetchDescriptor) ?? []) ?? nil
            prompt = nil
        } else {
            let fetchDescriptor = FetchDescriptor<PromptModel>(
                predicate: #Predicate {
                    $0.story?.uid == storyUid
                },
                sortBy: [SortDescriptor<PromptModel>(\.createdAt)]
            )
            
            prompt = (try? modelContext?.fetch(fetchDescriptor).first ?? nil) ?? nil
            promptScan = nil
        }
    }
}
