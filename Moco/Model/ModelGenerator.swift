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

    @MainActor static func populateContainer<T: PersistentModel>(container: ModelContainer, items: [T]) {
        var modelFetchDescriptor = FetchDescriptor<T>()
        modelFetchDescriptor.fetchLimit = 1

        do {
            guard try container.mainContext.fetch(modelFetchDescriptor).isEmpty else { return }

            // MARK: - This code will only run if the persistent store is empty.

            for item in items {
                container.mainContext.insert(item)
            }
        } catch {
            print("Cannot populate container")
        }
    }

    @MainActor
    static let generator = {
        let schema = Schema(models)
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])

            let dataToBePopulated = [
                "storyThemeModel": [
                    StoryThemeModel(
                        pictureName: "Story/Cover/Story1",
                        descriptionTheme: "Story 1",
                        title: "Story 1",
                        stories: [StoryModel(background: "", pageNumber: 0, isHavePrompt: false)]
                    )
                ]
            ]

            for (_, datum) in dataToBePopulated {
                ModelGenerator.populateContainer(container: container, items: datum)
            }

            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}
