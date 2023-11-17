//
//  EpisodeModel.swift
//  Moco
//
//  Created by Nur Azizah on 31/10/23.
//

import Foundation
import SwiftData

@Model
final class EpisodeModel: Identifiable, CustomPersistentModel {
    @Attribute var uid: String = ""
    @Attribute var slug: String = ""
    @Attribute var pictureName: String = ""
    @Attribute var isAvailable: Bool = false
    @Attribute var createdAt = Date()
    @Attribute var updatedAt = Date()

    var stories: [StoryModel]?
    var storyTheme: StoryThemeModel?

    init(pictureName: String, stories: [StoryModel]?, slug: String = "", isAvailable: Bool) {
        uid = UUID().uuidString
        self.slug = slug
        self.pictureName = pictureName
        self.stories = stories
        self.isAvailable = isAvailable
        createdAt = Date()
        updatedAt = Date()
    }
}
