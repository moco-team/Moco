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
    var id: String = ""
    var hint: String = ""
    var createdAt = Date()
    var updatedAt = Date()
    
    var prompt: PromptModel? = nil
    
    init(hint: String) {
        id = UUID().uuidString
        self.hint = hint
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}
