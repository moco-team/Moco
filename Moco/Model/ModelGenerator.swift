//
//  ModelGenerator.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 13/10/23.
//

import SwiftData
import SwiftUI

struct ModelGenerator {
    private static let models: [any PersistentModel.Type] = [
        CollectionModel.self,
        StoryThemeModel.self,
        EpisodeModel.self,
        StoryModel.self,
        StoryContentModel.self,
        PromptModel.self,
        HintModel.self
    ]

    @MainActor
    static func populateContainer<T: CustomPersistentModel>(container: ModelContainer, items: [T]) {
        let modelFetchDescriptor = FetchDescriptor<T>()
        let modelContext = ModelContext(container)

        do {
            let res = try modelContext.fetch(modelFetchDescriptor)

            // MARK: - This code will only run if the persistent store is empty.

            for item in res {
                modelContext.delete(item)
            }

            for item in items {
                res.forEach {
                    if $0.slug == item.slug {
                        modelContext.delete($0)
                    }
                }
                modelContext.insert(item)
            }
            try? modelContext.save()
        } catch {
            print("Cannot populate container")
        }
    }

    @MainActor static func populate() {
        for (_, datum) in ModelData.dataToBePopulated {
            ModelGenerator.populateContainer(container: MocoApp.modelContext.container, items: datum)
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

            for (_, datum) in ModelData.dataToBePopulated {
                ModelGenerator.populateContainer(container: container, items: datum)
            }

            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
}
