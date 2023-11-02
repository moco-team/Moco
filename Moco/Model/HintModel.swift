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
    @Attribute var uid: String = ""
    @Attribute var hint: String = ""
    @Attribute var createdAt = Date()
    @Attribute var updatedAt = Date()

    var prompt: PromptModel? = nil
    
    init(hint: String) {
        self.uid = UUID().uuidString
        self.hint = hint
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}
