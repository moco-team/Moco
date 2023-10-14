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

    private static let sharedModelContainer: ModelContainer = ModelGenerator.generator()
    static let modelContext = ModelContext(sharedModelContainer)

    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.itemViewModel, itemViewModel)
        }
    }
}
