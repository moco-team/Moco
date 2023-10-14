//
//  HomeView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 11/10/23.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @Environment(\.itemViewModel) private var itemViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(itemViewModel.items) { item in
                    Text(item.name)
                }.onDelete { indexSet in
                    for index in indexSet {
                        itemViewModel.deleteItem(index)
                    }
                }
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
    var sharedModelContainer: ModelContainer = ModelGenerator.generator()

    @State var itemViewModel = ItemViewModel(modelContext: ModelContext(sharedModelContainer))

    return HomeView().environment(\.itemViewModel, itemViewModel)
}
