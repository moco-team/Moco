//
//  AudioViewModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 17/10/23.
//

import AVFoundation

@Observable class AudioViewModel: NSObject, AVAudioPlayerDelegate {
    private var audioModel = AudioModel()

    /// Plays a sound with arbitrary filename and type, specify numberOfLoops = -1 to play indefinitely
    func playSound(soundFileName: String, type: String = "mp3", numberOfLoops: Int = 0, volume: Float = 1) {
        audioModel.playSound(soundFileName: soundFileName, type: type, numberOfLoops: numberOfLoops, volume: volume)
    }

    /// Stop a sound from playing
    func stopSound(soundFileName: String, type: String = "mp3") {
        audioModel.stopSound(soundFileName: soundFileName, type: type)
    }

    /// Stop all sounds from playing
    func stopAllSounds() {
        audioModel.stopAllSounds()
    }

    func playSounds(soundFileNames: [String]) {
        audioModel.playSounds(soundFileNames: soundFileNames)
    }

    func playSounds(soundFileNames: String...) {
        audioModel.playSounds(soundFileNames: soundFileNames)
    }

    /// Mute audio
    func mute() {
        audioModel.mute()
    }

    /// Unmute audio
    func unmute() {
        audioModel.unmute()
    }

    func playSounds(soundFileNames: [String], withDelay: Double) { // withDelay is in seconds
        soundFileNames.enumerated().forEach { index, soundFileName in
            let delay = withDelay * Double(index)
            _ = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(playSoundNotification(_:)), userInfo: ["fileName": soundFileName], repeats: false)
        }
    }

    func playSoundsQueue(sounds: [AudioModel.QueuePlayerParam], intervalDuration: Double = 0, volume: Float = 1, id: String? = nil) {
        audioModel.playSoundsQueue(sounds: sounds, intervalDuration: intervalDuration, volume: volume, id: id)
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
