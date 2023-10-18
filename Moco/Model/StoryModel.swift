//
//  StoryModel.swift
//  Moco
//
//  Created by Nur Azizah on 16/10/23.
//

import Foundation
import SwiftData

let a = [2, 2, 1, 1, 3]

@Model
final class StoryModel: Identifiable {
    var id: String = UUID().uuidString
    var background: String = ""
    var pageNumber: Int = 0
    var isHavePrompt: Bool = false
    var createdAt = Date()
    var updatedAt = Date()

    var storyTheme: StoryThemeModel?
    var prompts: [PromptModel]?
    var storyContents: [StoryContentModel]?

    init(background: String, pageNumber: Int, isHavePrompt: Bool) {
        self.background = background
        self.pageNumber = pageNumber
        self.isHavePrompt = isHavePrompt
        createdAt = Date()
        updatedAt = Date()
    }
}
