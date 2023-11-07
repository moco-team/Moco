//
//  GlobalStorage.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 27/10/23.
//

import SwiftUI

enum GlobalStorage {
    @AppStorage("BACKSOUND_VOLUME") static var backsoundVolume = 1.0
    @AppStorage("NARRATION_VOLUME") static var narrationVolume = 1.0
    @AppStorage("SOUND_EFFECT_VOLUME") static var soundEffectVolume = 1.0
}
