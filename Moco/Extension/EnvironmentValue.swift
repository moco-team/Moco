//
//  EnvironmentValue.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 13/10/23.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    var audioViewModel: AudioViewModel {
        get { self[AudioViewModelKey.self] }
        set { self[AudioViewModelKey.self] = newValue }
    }
    var itemViewModel: ItemViewModel {
        get { self[ItemViewModelKey.self] }
        set { self[ItemViewModelKey.self] = newValue }
    }
}


private struct AudioViewModelKey: EnvironmentKey {
    static var defaultValue: AudioViewModel = .init()
}

private struct ItemViewModelKey: EnvironmentKey {
    static var defaultValue: ItemViewModel = .init()
}