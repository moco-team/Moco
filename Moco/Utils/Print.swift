//
//  Print.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 15/10/23.
//

import Foundation

public func print(_ object: Any...) {
    #if DEBUG
        for item in object {
            Swift.print(item)
        }
    #endif
}

public func print(_ object: Any) {
    #if DEBUG
        Swift.print(object)
    #endif
}
