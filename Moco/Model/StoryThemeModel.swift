//
//  StoryThemeModel.swift
//  Moco
//
//  Created by Nur Azizah on 16/10/23.
//

import Foundation
import SwiftData

@Model
final class StoryThemeModel: Identifiable {
    var id: String = ""
    var pictureName: String = ""
    var descriptionTheme: String = ""
    var createdAt = Date()
    var updatedAt = Date()
    
    var stories: [StoryModel]?
    
    init(pictureName: String, descriptionTheme: String) {
        id = UUID().uuidString
        self.pictureName = pictureName
        self.descriptionTheme = descriptionTheme
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}
