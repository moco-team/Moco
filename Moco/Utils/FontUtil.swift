//
//  FontUtil.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 17/10/23.
//

import SwiftUI

public func printFonts() {
    for family in UIFont.familyNames.sorted() {
        let names = UIFont.fontNames(forFamilyName: family)
        print("Family: \(family) Font names: \(names)")
    }
}

enum CustomFontType {
    case cherryBomb
}
