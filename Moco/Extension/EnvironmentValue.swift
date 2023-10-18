//
//  EnvironmentValue.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 13/10/23.
//

import Foundation
import SwiftUI

// MARK: - Environment Values

extension EnvironmentValues {
    var audioViewModel: AudioViewModel {
        get { self[AudioViewModelKey.self] }
        set { self[AudioViewModelKey.self] = newValue }
    }

    var timerViewModel: TimerViewModel {
        get { self[TimerViewModelKey.self] }
        set { self[TimerViewModelKey.self] = newValue }
    }

    var itemViewModel: ItemViewModel {
        get { self[ItemViewModelKey.self] }
        set { self[ItemViewModelKey.self] = newValue }
    }
}

// MARK: - View Model Keys

private struct AudioViewModelKey: EnvironmentKey {
    static var defaultValue: AudioViewModel = .init()
}

private struct TimerViewModelKey: EnvironmentKey {
    static var defaultValue: TimerViewModel = .init()
}

private struct ItemViewModelKey: EnvironmentKey {
    static var defaultValue: ItemViewModel = .init()
}
