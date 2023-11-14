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
    @Attribute var earlyPrompt = false
    @Attribute var enableUI = true
    @Attribute var createdAt = Date()
    @Attribute var updatedAt = Date()

    var isHavePrompt: Bool {
        prompt != nil
    }

    var episode: EpisodeModel?
    var prompt: [PromptModel]?
    var storyContents: [StoryContentModel]?

    init(
        background: String,
        pageNumber: Int,
        isHavePrompt _: Bool = false,
        prompt: [PromptModel]? = nil,
        storyContents: [StoryContentModel]? = nil,
        enableUI _: Bool = true,
        earlyPrompt: Bool = false
    ) {
        uid = UUID().uuidString
        self.background = background
        self.pageNumber = pageNumber
        self.prompt = prompt
        self.storyContents = storyContents
        self.earlyPrompt = (prompt != nil) ? earlyPrompt : false
        createdAt = Date()
        updatedAt = Date()
    }
}
