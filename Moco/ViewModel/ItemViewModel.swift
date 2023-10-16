//
//  ItemViewModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 13/10/23.
//

import Foundation
import SwiftData
import SwiftUI

@Observable class ItemViewModel: BaseViewModel {
    var items = [Item]()

    init(modelContext: ModelContext? = nil, repository: ItemRepository) {
        super.init()
        self.repository = repository
        items = repository.fetchAll()
    }
    
    func createItem() {
        _ = repository!.create(Item(name: "azab"))
        items = repository!.fetchAll()
    }
    
    func deleteItem(_ item: Item) {
        _ = repository!.delete(item)
        items = repository!.fetchAll()
    }
    
    func deleteItem(at index: Int) {
        guard index >= 0, index < items.count else {
            return // Index out of bounds
        }

        let item = items.remove(at: index)

        _ = repository!.delete(item)
        items = repository!.fetchAll()
    }
}
