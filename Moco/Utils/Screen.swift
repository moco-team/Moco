//
//  Screen.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 15/10/23.
//

import SwiftUI

struct Screen {
    static var width: Double {
        UIScreen.main.bounds.size.width
    }

    static var height: Double {
        UIScreen.main.bounds.size.height
    }

    static var size: CGSize {
        UIScreen.main.bounds.size
    }
}
