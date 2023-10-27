//
//  CustomPersistentModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 27/10/23.
//

import SwiftData

protocol CustomPersistentModel: PersistentModel {
    var slug: String { get set }
}
