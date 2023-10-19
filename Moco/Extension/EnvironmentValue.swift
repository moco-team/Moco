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
    var storyThemeViewModel: StoryThemeViewModel {
        get { self[StoryThemeViewModelKey.self] }
        set { self[StoryThemeViewModelKey.self] = newValue }
    }
    var storyViewModel: StoryViewModel {
        get { self[StoryViewModelKey.self] }
        set { self[StoryViewModelKey.self] = newValue }
    }
    var promptViewModel: PromptViewModel {
        get { self[PromptViewModelKey.self] }
        set { self[PromptViewModelKey.self] = newValue }
    }
    var HintViewModel: HintViewModel {
        get { self[HintViewModelKey.self] }
        set { self[HintViewModelKey.self] = newValue }
    }
    var storyContentViewModel: StoryContentViewModel {
        get { self[StoryContentViewModelKey.self] }
        set { self[StoryContentViewModelKey.self] = newValue }
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

private struct StoryThemeViewModelKey: EnvironmentKey {
    static var defaultValue: StoryThemeViewModel = .init()
}

private struct StoryViewModelKey: EnvironmentKey {
    static var defaultValue: StoryViewModel = .init()
}

private struct PromptViewModelKey: EnvironmentKey {
    static var defaultValue: PromptViewModel = .init()
}

private struct HintViewModelKey: EnvironmentKey {
    static var defaultValue: HintViewModel = .init()
}

private struct StoryContentViewModelKey: EnvironmentKey {
    static var defaultValue: StoryContentViewModel = .init()
}
