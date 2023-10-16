//
//  BaseRepository.swift
//  Moco
//
//  Created by Carissa Farry Hilmi Az Zahra on 15/10/23.
//

import Foundation
import SwiftData

protocol BaseRepositoryProtocol {
    associatedtype Model
    
    func fetchAll() -> [Model]
    func create(_ item: Model) -> Model
    func update(_ item: Model) -> Bool
    func delete(_ item: Model) -> Bool
}

class BaseRepository<T> {
    var modelContext: ModelContext = MocoApp.modelContext
    
    init(modelContext: ModelContext? = nil) {
        if modelContext != nil {
            self.modelContext = modelContext!
        }
    }
}
