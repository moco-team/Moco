//
//  PromptModel.swift
//  Moco
//
//  Created by Nur Azizah on 16/10/23.
//

import Foundation
import SwiftData

@Model
final class PromptModel: Identifiable {
    var id: String = ""
    var prompt_description: String = ""
    var correctAnswer: String = ""
    var duration: TimeInterval = 0.0
    var prompt_type: String = ""
    var createdAt = Date()
    var updatedAt = Date()
    
    var story: StoryModel? = nil
    var hints: [HintModel]?
    
    init(prompt_description: String, correctAnswer: String, duration: TimeInterval, prompt_type: String) {
        id = UUID().uuidString
        self.prompt_description = prompt_description
        self.correctAnswer = correctAnswer
        self.duration = duration
        self.prompt_type = prompt_type
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}
