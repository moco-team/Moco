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
    @Attribute var uid: String = ""
    @Attribute var background: String = ""
    @Attribute var pageNumber: Int = 0
    @Attribute var isHavePrompt: Bool = false
    @Attribute var createdAt = Date()
    @Attribute var updatedAt = Date()

    var episode: EpisodeModel?
    var prompt: PromptModel?
    var storyContents: [StoryContentModel]?

    init(background: String, pageNumber: Int, isHavePrompt: Bool, prompt: PromptModel?, storyContents: [StoryContentModel]?) {
        uid = UUID().uuidString
        self.background = background
        self.pageNumber = pageNumber
        self.isHavePrompt = isHavePrompt
        self.prompt = prompt
        self.storyContents = storyContents
        createdAt = Date()
        updatedAt = Date()
    }
}
