//
//  Dictionary.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 25/10/23.
//

import Foundation

extension Dictionary where Value: Hashable {
    func swapKeyValues() -> [Value: Key] {
        assert(Set(values).count == keys.count, "Values must be unique")
        var newDict = [Value: Key]()
        for (key, value) in self {
            newDict[value] = key
        }
        return newDict
    }
}
