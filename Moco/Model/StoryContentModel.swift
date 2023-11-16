//
//  StoryContentModel.swift
//  Moco
//
//  Created by Nur Azizah on 16/10/23.
//

import Foundation
import SwiftData
import SwiftUI

enum StoryContentType: String, Codable {
    case text
    case audio
    case lottie
}

@Model
final class StoryContentModel: Identifiable {
    @Attribute var uid: String = ""
    @Attribute var duration: Double = 0.0
    @Attribute var contentName: String = ""
    @Attribute var contentType = StoryContentType.text
    @Attribute var positionX: Double = 0.0
    @Attribute var positionY: Double = 0.0
    @Attribute var maxWidth: Double? = Screen.width * 0.5
    @Attribute var color: String? = ""
    @Attribute var fontSize: CGFloat = 30
    @Attribute var createdAt = Date()
    @Attribute var updatedAt = Date()

    var story: StoryModel? = nil

    init(duration: Double = 0.0,
         contentName: String = "",
         contentType: StoryContentType = StoryContentType.text,
         positionX: Double = 0.0,
         positionY: Double = 0.0,
         maxWidth: Double = 0.0,
         color: String? = nil,
         fontSize: CGFloat = 0.0) {
        uid = UUID().uuidString
        self.duration = duration
        self.contentName = contentName
        self.contentType = contentType
        self.positionX = positionX
        self.positionY = positionY
        self.maxWidth = maxWidth
        self.color = color
        self.fontSize = fontSize
        createdAt = Date()
        updatedAt = Date()
    }
}
