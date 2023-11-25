//
//  UserModel.swift
//  Moco
//
//  Created by Nur Azizah on 24/11/23.
//

import Foundation
import SwiftData

@Model
final class UserModel: Identifiable, CustomPersistentModel {
    @Attribute var uid: String = ""
    @Attribute var slug: String = ""
    @Attribute var availableStoryThemeSum: Int = 1
    @Attribute var availableEpisodeSum: Int = 0
    @Attribute var createdAt = Date()
    @Attribute var updatedAt = Date()

    var storyThemes: [StoryThemeModel]?

    init(availableStoryThemeSum: Int, availableEpisodeSum: Int, slug: String = "") {
        uid = UUID().uuidString
        self.slug = slug
        self.availableStoryThemeSum = availableStoryThemeSum
        self.availableEpisodeSum = availableEpisodeSum
        createdAt = Date()
        updatedAt = Date()
    }
}
