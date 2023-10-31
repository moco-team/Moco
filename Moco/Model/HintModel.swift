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
    @Attribute var id: String = UUID().uuidString
    @Attribute var hint: String = ""
    @Attribute var createdAt = Date()
    @Attribute var updatedAt = Date()

    @Attribute var prompt: PromptModel?

    init(hint: String) {
        self.hint = hint
        createdAt = Date()
        updatedAt = Date()
    }
}
