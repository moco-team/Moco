//
//  ItemViewModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 13/10/23.
//

import Foundation
import SwiftData

@Observable class ItemViewModel: BaseViewModel {
    var items = [Item]()

    init(modelContext: ModelContext? = nil) {
        super.init()
        if modelContext != nil {
            self.modelContext = modelContext
        }
        if self.modelContext != nil {
            fetchItems()
        }
    }

    func fetchItems() {
        let fetchDescriptor = FetchDescriptor<Item>(
            predicate: #Predicate {
                $0.name != "SecretItem"
            },
            sortBy: [SortDescriptor<Item>(\.name)]
        )
        items = (try? modelContext?.fetch(fetchDescriptor) ?? []) ?? []
    }

    func createItem() {
        let newItem = Item(name: "bozo")
        modelContext?.insert(newItem)
        try? modelContext?.save()

        fetchItems()
    }

    func deleteItem(item: Item) {
        modelContext?.delete(item)
        try? modelContext?.save()

        fetchItems()
    }

    func deleteItem(_ index: Int) {
        guard items.indices.contains(index) else { return }
        modelContext?.delete(items[index])
        try? modelContext?.save()

        fetchItems()
    }
}
