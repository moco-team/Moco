//
//  ModelGenerator.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 13/10/23.
//

import SwiftData

struct ModelGenerator {
    private static let models: [any PersistentModel.Type] = [
        Item.self,
        CollectionModel.self,
        StoryThemeModel.self,
        StoryModel.self,
        StoryContentModel.self,
        PromptModel.self,
        HintModel.self
    ]

    static var generator = {
        let schema = Schema(models)
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}
