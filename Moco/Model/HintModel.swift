//
//  HintModel.swift
//  Moco
//
//  Created by Nur Azizah on 16/10/23.
//

import Foundation
import SwiftData

@Model
final class HintModel: Identifiable {
    var id: String = UUID().uuidString
    var hint: String = ""
    var createdAt = Date()
    var updatedAt = Date()

    var prompt: PromptModel?

    init(hint: String) {
        self.hint = hint
        createdAt = Date()
        updatedAt = Date()
    }
}
