//
//  StoryModel.swift
//  Moco
//
//  Created by Nur Azizah on 16/10/23.
//

import Foundation
import SwiftData

@Model
final class StoryModel: Identifiable {
    @Attribute var id: String = UUID().uuidString
    @Attribute var background: String = ""
    @Attribute var pageNumber: Int = 0
    @Attribute var isHavePrompt: Bool = false
    @Attribute var createdAt = Date()
    @Attribute var updatedAt = Date()

    @Attribute var storyTheme: StoryThemeModel?
    @Attribute var prompts: [PromptModel]?
    @Attribute var storyContents: [StoryContentModel]?

    init(background: String, pageNumber: Int, isHavePrompt: Bool) {
        self.background = background
        self.pageNumber = pageNumber
        self.isHavePrompt = isHavePrompt
        createdAt = Date()
        updatedAt = Date()
    }
}
