//
//  Item.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 11/10/23.
//

import Foundation
import SwiftData

@Model class Item {
    @Attribute var name = ""
    @Attribute var image = ""

    init(name: String = "", image: String = "") {
        self.name = name
        self.image = image
    }
}
