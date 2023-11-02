//
//  HintViewModel.swift
//  Moco
//
//  Created by Nur Azizah on 16/10/23.
//

import Foundation
import SwiftData

@Observable class HintViewModel: BaseViewModel {
    static var shared = HintViewModel()
    
    var hints = [HintModel]()

    init(modelContext: ModelContext? = nil) {
        super.init()
        if modelContext != nil {
            self.modelContext = modelContext
        }
    }
    
    func fetchHints(_ prompt: PromptModel) {
        let promptUid = prompt.uid
        
        let fetchDescriptor = FetchDescriptor<HintModel>(
            predicate: #Predicate {
                $0.prompt?.uid == promptUid
            },
            sortBy: [SortDescriptor<HintModel>(\.createdAt)]
        )
        
        hints = (try? modelContext?.fetch(fetchDescriptor) ?? []) ?? []
    }
}
