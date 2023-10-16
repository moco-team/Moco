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
    var id: String = ""
    var duration: TimeInterval = 0.0
    var contentName: String = ""
    var contentType: String = ""
    var createdAt = Date()
    var updatedAt = Date()
    
    var stories: [StoryModel]? = nil
    
    init(duration: TimeInterval, contentName: String, contentType: String) {
        id = UUID().uuidString
        self.duration = duration
        self.contentName = contentName
        self.contentType = contentType
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}
