//
//  ContentView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 11/10/23.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        // MARK: - First Vew Declaration

        HomeView()
    }
}

#Preview {
    CollectionView()
        .modelContainer(for: CollectionModel.self, inMemory: true)
}
