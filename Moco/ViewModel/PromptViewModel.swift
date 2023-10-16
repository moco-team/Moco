//
//  PromptViewModel.swift
//  Moco
//
//  Created by Nur Azizah on 16/10/23.
//

import Foundation
import SwiftData

@Observable class PromptViewModel: BaseViewModel {
    var prompts = [PromptModel]()

    init(modelContext: ModelContext? = nil) {
        super.init()
        if modelContext != nil {
            self.modelContext = modelContext
        }
        if self.modelContext != nil {
            fetchPrompts(nil)
        }
    }

    func fetchPrompts(_ story: StoryModel?) {
        let storyId = story?.id
        let fetchDescriptor = FetchDescriptor<PromptModel>(
            predicate: #Predicate {
                $0.story?.id == storyId
            },
            sortBy: [SortDescriptor<PromptModel>(\.createdAt)]
        )

        prompts = (try? modelContext?.fetch(fetchDescriptor) ?? []) ?? []
    }

    func createPrompt(hints: [HintModel], story: StoryModel) {
        let newPrompt = PromptModel(promptDescription: "desc", correctAnswer: "correct", duration: 1.0, promptType: "object detection")
        newPrompt.story = story
        newPrompt.hints = hints

        modelContext?.insert(newPrompt)
        try? modelContext?.save()

        fetchPrompts(story)
    }

    func deletePrompt(prompt: PromptModel, story: StoryModel) {
        modelContext?.delete(prompt)
        try? modelContext?.save()

        fetchPrompts(story)
    }

    func deletePrompt(index: Int, story: StoryModel) {
        guard prompts.indices.contains(index) else { return }
        modelContext?.delete(prompts[index])
        try? modelContext?.save()

        fetchPrompts(story)
    }
}
