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
    var id: String = ""
    var slug: String = ""
    var pictureName: String = ""
    var descriptionTheme: String = ""
    var title: String = ""
    var createdAt = Date()
    var updatedAt = Date()

    var stories: [StoryModel]?

    init(pictureName: String, descriptionTheme: String, title: String = "", stories: [StoryModel]? = nil, slug: String = "") {
        id = UUID().uuidString
        self.slug = slug
        self.pictureName = pictureName
        self.descriptionTheme = descriptionTheme
        self.title = title
        self.stories = stories
        createdAt = Date()
        updatedAt = Date()
    }
}
