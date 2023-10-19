//
//  AudioModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 17/10/23.
//

import AVFoundation

struct AudioModel: Identifiable, Equatable {
    var players: [URL: AVAudioPlayer] = [:]
    var playerVolumes: [URL: Float] = [:]
    var duplicatePlayers: [AVAudioPlayer] = []

    var volume: Float {
        players.first?.value.volume ?? 0
    }

    var id = UUID()

    mutating func mute() {
        setVolume(0, writePlayerVolumes: false)
    }

    mutating func unmute() {
        setVolume(nil)
    }

    mutating func setVolume(_ volume: Float?, writePlayerVolumes: Bool = true) {
        players.forEach { _, value in
            setVolume(volume, player: value, writePlayerVolumes: writePlayerVolumes)
        }
    }

    mutating func setVolume(_ volume: Float?, soundFileName: String, type: String = "mp3", writePlayerVolumes: Bool = true) {
        guard let bundle = Bundle.main.path(forResource: soundFileName, ofType: type) else { return }
        let soundFileNameURL = URL(fileURLWithPath: bundle)

        setVolume(volume, soundFileNameURL: soundFileNameURL, writePlayerVolumes: writePlayerVolumes)
    }

    mutating func setVolume(_ volume: Float?, soundFileNameURL: URL, writePlayerVolumes: Bool = true) {
        if let player = players[soundFileNameURL] {
            setVolume(volume, player: player, writePlayerVolumes: writePlayerVolumes)
        }
    }

    mutating func setVolume(_ volume: Float?, player: AVAudioPlayer, writePlayerVolumes: Bool = true) {
        if let playerURL = player.url {
            if volume != nil && writePlayerVolumes {
                playerVolumes[playerURL] = volume
            }
            player.setVolume(volume ?? (playerVolumes[playerURL] ?? 0), fadeDuration: 0)
        } else {
            player.setVolume(volume ?? 1, fadeDuration: 0)
        }
    }

    func isMuted() -> Bool {
        return players.allSatisfy { _, value in
            isMuted(value)
        }
    }

    func isMuted(_ soundFileName: String, type: String = "mp3") -> Bool {
        guard let bundle = Bundle.main.path(forResource: soundFileName, ofType: type) else { return false }
        let soundFileNameURL = URL(fileURLWithPath: bundle)

        return isMuted(soundFileNameURL)
    }

    func isMuted(_ soundFileNameURL: URL) -> Bool {
        return isMuted(players[soundFileNameURL])
    }

    func isMuted(_ player: AVAudioPlayer?) -> Bool {
        return player?.volume == 0
    }

    mutating func playSound(soundFileName: String, type: String = "mp3", numberOfLoops: Int = 0, volume: Float = 1) {
        guard let bundle = Bundle.main.path(forResource: soundFileName, ofType: type) else { return }
        let soundFileNameURL = URL(fileURLWithPath: bundle)

        if let player = players[soundFileNameURL] { // player for sound has been found
            if !player.isPlaying { // player is not in use, so use that one
                player.numberOfLoops = numberOfLoops
                setVolume(volume, player: player)
                player.prepareToPlay()
                player.play()
            }
        } else { // player has not been found, create a new player with the URL if possible
            do {
                let player = try AVAudioPlayer(contentsOf: soundFileNameURL)
                players[soundFileNameURL] = player
                player.numberOfLoops = numberOfLoops
                setVolume(volume, player: player)
                player.prepareToPlay()
                player.play()
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func stopSound(soundFileName: String, type: String = "mp3") {
        guard let bundle = Bundle.main.path(forResource: soundFileName, ofType: type) else { return }
        let soundFileNameURL = URL(fileURLWithPath: bundle)

        if let player = players[soundFileNameURL] { // player for sound has been found
            if player.isPlaying { // player is not in use, so use that one
                player.stop()
            }
        }
    }

    func stopAllSounds() {
        players.forEach { _, value in
            value.stop()
        }
    }

    mutating func playSounds(soundFileNames: [String]) {
        soundFileNames.forEach { name in
            playSound(soundFileName: name)
        }
    }

    mutating func playSounds(soundFileNames: String...) {
        soundFileNames.forEach { name in
            playSound(soundFileName: name)
        }
    }

    mutating func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully _: Bool) {
        if let index = duplicatePlayers.firstIndex(of: player) {
            duplicatePlayers.remove(at: index)
        }
    }
}
