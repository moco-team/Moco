//
//  StoryContentModel.swift
//  Moco
//
//  Created by Nur Azizah on 16/10/23.
//

import Foundation
import SwiftData

@Model
final class StoryContentModel: Identifiable {
    @Attribute var id: String = ""
    @Attribute var duration: TimeInterval = 0.0
    @Attribute var contentName: String = ""
    @Attribute var contentType: String = ""
    @Attribute var createdAt = Date()
    @Attribute var updatedAt = Date()

    @Attribute var stories: [StoryModel]?

    init(duration: TimeInterval, contentName: String, contentType: String) {
        id = UUID().uuidString
        self.duration = duration
        self.contentName = contentName
        self.contentType = contentType
        createdAt = Date()
        updatedAt = Date()
    }
}
