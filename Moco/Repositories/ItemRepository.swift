//
//  ItemRepository.swift
//  Moco
//
//  Created by Carissa Farry Hilmi Az Zahra on 15/10/23.
//

import Foundation
import SwiftData

class ItemRepository: BaseRepository<Item>, BaseRepositoryProtocol {
    init() {
        super.init()
    }
    
    func fetchAll() -> [Item] {
        let fetchDescriptor = FetchDescriptor<Item>(
            predicate: #Predicate {
                $0.name == "azab"
            },
            sortBy: [SortDescriptor<Item>(\.name)]
        )
        let items = (try? self.modelContext.fetch(fetchDescriptor)) ?? []
        return items
    }
    
    func create(_ item: Item) -> Item {
        modelContext.insert(item)
        try? modelContext.save()
        return item
    }
    
    func update(_ item: Item) -> Bool {
        //
        return true
    }
    
    func delete(_ item: Item) -> Bool {
        modelContext.delete(item)
        try? modelContext.save()
        return true
    }
}
