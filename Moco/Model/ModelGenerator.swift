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

    @MainActor static func populateContainer<T: CustomPersistentModel>(container: ModelContainer, items: [T]) {
        let modelFetchDescriptor = FetchDescriptor<T>()

        let modelContext = ModelContext(container)

        do {
            let res = try modelContext.fetch(modelFetchDescriptor)

            // MARK: - This code will only run if the persistent store is empty.

            for item in items {
                if res.contains(where: {
                    $0.slug == item.slug
                }) {
                    modelContext.delete(res.first {
                        $0.slug == item.slug
                    }!)
                }
                modelContext.insert(item)
            }
            try? modelContext.save()
        } catch {
            print("Cannot populate container")
        }
    }

    @MainActor
    static let generator = { (inMemory: Bool) in
        let schema = Schema(models)
        let modelConfiguration = inMemory ?
            ModelConfiguration(schema: schema, isStoredInMemoryOnly: inMemory, cloudKitDatabase: .none) :
            ModelConfiguration(schema: schema, isStoredInMemoryOnly: inMemory)

        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])

            // !!!: TO BE POPULATED, A MODEL MUST IMPLEMENT CustomPersistentModel
            let dataToBePopulated = [
                "storyThemeModel": [
                    StoryThemeModel(
                        pictureName: "Story/Cover/Story1",
                        descriptionTheme: "Story 1",
                        title: "Story 1",
                        stories: [StoryModel(background: "", pageNumber: 0, isHavePrompt: false)],
                        slug: "story-1"
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
