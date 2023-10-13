//
//  HomeView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 11/10/23.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.itemViewModel) private var itemViewModel

    var body: some View {
        NavigationStack {
            List(itemViewModel.items) { item in
                Text(item.name)
            }
            .toolbar {
                Button("Add") {
                    itemViewModel.createItem()
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: Item.self, inMemory: true)
}
