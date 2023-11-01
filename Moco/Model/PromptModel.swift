//
//  PromptModel.swift
//  Moco
//
//  Created by Nur Azizah on 16/10/23.
//

import Foundation
import SwiftData

enum PromptType {
    case puzzle
    case findHoney
    case objectDetection
    case speech
    case multipleChoice
    case maze
}

@Model
final class PromptModel: Identifiable {
    @Attribute var id: String = UUID().uuidString
    @Attribute var promptDescription = ""
    @Attribute var correctAnswer = ""
    @Attribute var duration: TimeInterval = 0.0
    @Attribute var promptType = ""
    @Attribute var createdAt = Date()
    @Attribute var updatedAt = Date()

    @Attribute var story: StoryModel?
    @Attribute var hints: [HintModel]?

    init(promptDescription: String, correctAnswer: String, duration: TimeInterval, promptType: String) {
        self.promptDescription = promptDescription
        self.correctAnswer = correctAnswer
        self.duration = duration
        self.promptType = promptType
        createdAt = Date()
        updatedAt = Date()
    }
}
