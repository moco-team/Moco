//
//  CollectionModel.swift
//  Moco
//
//  Created by Nur Azizah on 12/10/23.
//

import Foundation
import SwiftData

@Model
final class CollectionModel: Identifiable {
    var id: String = ""
    var collectionDescription: String = ""
    var image: String = ""
    var createdAt = Date()
    var updatedAt = Date()

    init(collectionDescription: String, image: String) {
        id = UUID().uuidString
        self.collectionDescription = collectionDescription
        self.image = image
        createdAt = Date()
        updatedAt = Date()
    }
}
