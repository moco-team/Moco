//
//  MocoApp.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 11/10/23.
//

import SwiftData
import SwiftUI

@main
struct MocoApp: App {
    @State private var itemViewModel = ItemViewModel()

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    init() {
        itemViewModel.modelContext = ModelContext(sharedModelContainer)
        itemViewModel.fetchItems()
    }

    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.itemViewModel, itemViewModel)
        }
        .modelContainer(sharedModelContainer)
    }
}
