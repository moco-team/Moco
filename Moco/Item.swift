//
//  Item.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 11/10/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp = Date()

    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
