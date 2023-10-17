//
//  AudioViewModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 17/10/23.
//

import AVFoundation

@Observable class AudioViewModel: NSObject, AVAudioPlayerDelegate {
    private var audioModel = AudioModel()

    func playSound(soundFileName: String, type: String = "mp3", numberOfLoops: Int = 0) {
        audioModel.playSound(soundFileName: soundFileName, type: type, numberOfLoops: numberOfLoops)
    }

    func stopSound(soundFileName: String, type: String = "mp3") {
        audioModel.stopSound(soundFileName: soundFileName, type: type)
    }

    func stopAllSounds() {
        audioModel.stopAllSounds()
    }

    func playSounds(soundFileNames: [String]) {
        audioModel.playSounds(soundFileNames: soundFileNames)
    }

    func playSounds(soundFileNames: String...) {
        audioModel.playSounds(soundFileNames: soundFileNames)
    }

    func mute() {
        audioModel.mute()
    }

    func unmute() {
        audioModel.unmute()
    }

    func playSounds(soundFileNames: [String], withDelay: Double) { // withDelay is in seconds
        for (index, soundFileName) in soundFileNames.enumerated() {
            let delay = withDelay * Double(index)
            _ = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(playSoundNotification(_:)), userInfo: ["fileName": soundFileName], repeats: false)
        }
    }

    @objc func playSoundNotification(_ notification: NSNotification) {
        if let soundFileName = notification.userInfo?["fileName"] as? String {
            audioModel.playSound(soundFileName: soundFileName)
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully _: Bool) {
        audioModel.audioPlayerDidFinishPlaying(player, successfully: true)
    }
}
