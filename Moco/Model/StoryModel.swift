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
    var id: String = ""
    var background: String = ""
    var pageNumber: Int = 0
    var is_have_prompt: Bool = false
    var createdAt = Date()
    var updatedAt = Date()
    
    var storyTheme: StoryThemeModel? = nil
    var prompts: [PromptModel]?
    var storyContents: [StoryContentModel]?
    
    init(background: String, pageNumber: Int, is_have_prompt: Bool) {
        id = UUID().uuidString
        self.background = background
        self.pageNumber = pageNumber
        self.is_have_prompt = is_have_prompt
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}
