//
//  HomeViewModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 22/10/23.
//

import MediaPlayer
import SwiftUI

@Observable class HomeViewModel {
    private var homeModel = HomeModel()

    var soundLevel: Float {
        get {
            homeModel.soundLevel
        }
        set {
            homeModel.soundLevel = newValue
        }
    }

    func setVolume() {
        MPVolumeView.setVolume(soundLevel)
    }
}
