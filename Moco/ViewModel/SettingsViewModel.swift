//
//  SettingsViewModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 28/10/23.
//

import Foundation

@Observable class SettingsViewModel {
    static var shared = SettingsViewModel()
    var narrationVolume: Double {
        get {
            GlobalStorage.narrationVolume
        }
        set {
            GlobalStorage.narrationVolume = newValue
        }
    }

    var backsoundVolume: Double {
        get {
            GlobalStorage.backsoundVolume
        }
        set {
            GlobalStorage.backsoundVolume = newValue
        }
    }

    var soundEffectVolume: Double {
        get {
            GlobalStorage.soundEffectVolume
        }
        set {
            GlobalStorage.soundEffectVolume = newValue
        }
    }

    var mazeTutorialFinished: Bool {
        get {
            GlobalStorage.mazeTutorialFinished
        }
        set {
            GlobalStorage.mazeTutorialFinished = newValue
        }
    }

    var arTutorialFinished: Bool {
        get {
            GlobalStorage.arTutorialFinished
        }
        set {
            GlobalStorage.arTutorialFinished = newValue
        }
    }

    var storyTutorialFinished: Bool {
        get {
            GlobalStorage.arTutorialFinished
        }
        set {
            GlobalStorage.arTutorialFinished = newValue
        }
    }
}
