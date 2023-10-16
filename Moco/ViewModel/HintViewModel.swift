//
//  HintViewModel.swift
//  Moco
//
//  Created by Nur Azizah on 16/10/23.
//

import Foundation
import SwiftData

@Observable class HintViewModel: BaseViewModel {
    var hints = [HintModel]()
    
    init(modelContext: ModelContext? = nil) {
        super.init()
        if modelContext != nil {
            self.modelContext = modelContext
        }
        if self.modelContext != nil {
            fetchHints(nil)
        }
    }
    
    func fetchHints(_ prompt: PromptModel?) {
        let fetchDescriptor = FetchDescriptor<HintModel>(
            predicate: #Predicate {
                $0.prompt?.id == prompt?.id
            },
            sortBy: [SortDescriptor<HintModel>(\.createdAt)]
        )
        
        hints = (try? modelContext?.fetch(fetchDescriptor) ?? []) ?? []
    }
    
    func createHint(_ prompt: PromptModel) {
        let newHint = HintModel(hint: "new hint")
        newHint.prompt = prompt
        
        modelContext?.insert(newHint)
        try? modelContext?.save()
        
        fetchHints(prompt)
    }
    
    func deleteHint(prompt: PromptModel, hint: HintModel) {
        modelContext?.delete(hint)
        try? modelContext?.save()
        
        fetchHints(prompt)
    }
    
    func deleteHint(prompt: PromptModel, index: Int) {
        guard hints.indices.contains(index) else { return }
        modelContext?.delete(hints[index])
        try? modelContext?.save()
        
        fetchHints(prompt)
    }
}
