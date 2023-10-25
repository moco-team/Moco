//
//  Date.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 25/10/23.
//

import Foundation

extension Date {
    static func getCurrentMillis() -> Int {
        Int(Date().timeIntervalSince1970 * 1000)
    }
}
