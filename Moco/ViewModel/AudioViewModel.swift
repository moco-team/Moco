//
//  AudioViewModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 17/10/23.
//

import AVFoundation

@Observable class AudioViewModel: NSObject, AVAudioPlayerDelegate {
    static var shared = AudioViewModel()

    override init() {
        super.init()
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        } catch {
            print("Error setting AVAudioSession category")
        }
    }

    private var audioModel = AudioModel()

    /// Plays a sound with arbitrary filename and type, specify numberOfLoops = -1 to play indefinitely
    func playSound(soundFileName: String, type: String = "mp3", numberOfLoops: Int = 0, volume: Float = 1, category: AudioCategory? = nil) {
        guard !Process.isPreview else { return }
        let player = audioModel.playSound(soundFileName: soundFileName, type: type, numberOfLoops: numberOfLoops, volume: volume, category: category)
        player.delegate = self
    }

    func playSound(soundFileName: String) {
        playSound(soundFileName: soundFileName, type: .mp3, numberOfLoops: 0, volume: 1, category: nil)
    }

    func playSound(soundFileName: String, category: AudioCategory) {
        playSound(soundFileName: soundFileName, type: .mp3, numberOfLoops: 0, volume: 1, category: category)
    }

    func playSound(soundFileName: String, numberOfLoops: Int, category: AudioCategory) {
        playSound(soundFileName: soundFileName, type: .mp3, numberOfLoops: numberOfLoops, volume: 1, category: category)
    }

    func playSound(soundFileName: String, type: AudioType = .mp3, numberOfLoops: Int = 0, volume: Float = 1, category: AudioCategory? = nil) {
        playSound(soundFileName: soundFileName, type: type.rawValue, numberOfLoops: numberOfLoops, volume: volume, category: category)
    }

    /// Stop a sound from playing
    func stopSound(soundFileName: String, type: String = "mp3") {
        audioModel.stopSound(soundFileName: soundFileName, type: type)
    }

    /// Stop all sounds from playing
    func stopAllSounds() {
        audioModel.stopAllSounds()
    }

    func pauseAllSounds() {
        audioModel.pauseAllSounds()
    }

    /// Stop all sounds from playing
    func stopAllSoundsQueue() {
        audioModel.stopAllSoundsQueue()
    }

    func pauseAllSoundsQueue() {
        audioModel.pauseAllSoundsQueue()
    }

    func clearAll() {
        audioModel.clearAll()
    }

    func playSounds(soundFileNames: [String]) {
        guard !Process.isPreview else { return }
        audioModel.playSounds(soundFileNames: soundFileNames)
    }

    func playSounds(soundFileNames: String...) {
        guard !Process.isPreview else { return }
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
        guard !Process.isPreview else { return }
        soundFileNames.enumerated().forEach { index, soundFileName in
            let delay = withDelay * Double(index)
            _ = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(playSoundNotification(_:)), userInfo: ["fileName": soundFileName], repeats: false)
        }
    }

    func setVolume(_ volume: Float?, writePlayerVolumes: Bool = true) {
        audioModel.setVolume(volume, writePlayerVolumes: writePlayerVolumes)
    }

    func setVolumeByCategory(_ volume: Float, category: AudioCategory) {
        audioModel.setVolumeByCategory(volume, category: category)
    }

    func playSoundsQueue(sounds: [AudioModel.QueuePlayerParam], intervalDuration: Double = 0, volume: Float = 1, id: String? = nil, category: AudioCategory? = nil) {
        guard !Process.isPreview else { return }
        audioModel.playSoundsQueue(sounds: sounds, intervalDuration: intervalDuration, volume: volume, id: id, category: category)
    }

    @objc func playSoundNotification(_ notification: NSNotification) {
        guard !Process.isPreview else { return }
        if let soundFileName = notification.userInfo?["fileName"] as? String {
            _ = audioModel.playSound(soundFileName: soundFileName)
        }
    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully _: Bool) {
        audioModel.audioPlayerDidFinishPlaying(player, successfully: true)
    }
}
