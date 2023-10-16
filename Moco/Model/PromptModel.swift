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
    var id: String = UUID().uuidString
    var promptDescription: String = ""
    var correctAnswer: String = ""
    var duration: TimeInterval = 0.0
    var promptType: String = ""
    var createdAt = Date()
    var updatedAt = Date()

    var story: StoryModel?
    var hints: [HintModel]?

    init(promptDescription: String, correctAnswer: String, duration: TimeInterval, promptType: String) {
        self.promptDescription = promptDescription
        self.correctAnswer = correctAnswer
        self.duration = duration
        self.promptType = promptType
        createdAt = Date()
        updatedAt = Date()
    }
}
