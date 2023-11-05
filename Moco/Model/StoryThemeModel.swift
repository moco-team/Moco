//
//  StoryThemeModel.swift
//  Moco
//
//  Created by Nur Azizah on 16/10/23.
//

import Foundation
import SwiftData

@Model
final class StoryThemeModel: Identifiable, CustomPersistentModel {
    @Attribute var uid: String = ""
    @Attribute var slug: String = ""
    @Attribute var pictureName: String = ""
    @Attribute var createdAt = Date()
    @Attribute var updatedAt = Date()

    var episodes: [EpisodeModel]?

    init(pictureName: String, episodes: [EpisodeModel]?, slug: String = "") {
        uid = UUID().uuidString
        self.slug = slug
        self.pictureName = pictureName
        self.episodes = episodes
        createdAt = Date()
        updatedAt = Date()
    }
}
