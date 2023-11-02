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
    var storyTheme: StoryThemeModel? = nil

     init(pictureName: String, stories: [StoryModel]?, slug: String = "", isAvailable: Bool) {
        self.uid = UUID().uuidString
        self.slug = slug
        self.pictureName = pictureName
        self.stories = stories
        self.isAvailable = isAvailable
        self.createdAt = Date()
        self.updatedAt = Date()
    }
 }
