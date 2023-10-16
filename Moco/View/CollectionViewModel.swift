//
//  CollectionViewModel.swift
//  Moco
//
//  Created by Nur Azizah on 13/10/23.
//

import Foundation
import SwiftData

class CollectionViewModel {
    func addCollection(context: ModelContext, collection: CollectionModel) {
        context.insert(collection)
    }

    func deleteCollection(context: ModelContext, collection: CollectionModel) {
        context.delete(collection)
    }

    func updateCollection(context: ModelContext, lastCollection: CollectionModel, newCollection: CollectionModel) {
        lastCollection.collectionDescription = newCollection.collectionDescription
        lastCollection.image = newCollection.image

        try? context.save()
    }
}
