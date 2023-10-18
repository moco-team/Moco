//
//  AudioModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 17/10/23.
//

import AVFoundation

struct AudioModel: Identifiable, Equatable {
    var players: [URL: AVAudioPlayer] = [:]
    var duplicatePlayers: [AVAudioPlayer] = []

    var id = UUID()

    func mute() {
        for player in players {
            player.value.setVolume(0, fadeDuration: 0)
        }
    }

    func unmute() {
        for player in players {
            player.value.setVolume(1, fadeDuration: 0)
        }
    }

    mutating func playSound(soundFileName: String, type: String = "mp3", numberOfLoops: Int = 0, volume: Float = 1) {
        guard let bundle = Bundle.main.path(forResource: soundFileName, ofType: type) else { return }
        let soundFileNameURL = URL(fileURLWithPath: bundle)

        if let player = players[soundFileNameURL] { // player for sound has been found
            if !player.isPlaying { // player is not in use, so use that one
                player.numberOfLoops = numberOfLoops
                player.volume = volume
                player.prepareToPlay()
                player.play()
            }
        } else { // player has not been found, create a new player with the URL if possible
            do {
                let player = try AVAudioPlayer(contentsOf: soundFileNameURL)
                players[soundFileNameURL] = player
                player.numberOfLoops = numberOfLoops
                player.volume = volume
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
        for player in players {
            player.value.stop()
        }
    }

    mutating func playSounds(soundFileNames: [String]) {
        for soundFileName in soundFileNames {
            playSound(soundFileName: soundFileName)
        }
    }

    mutating func playSounds(soundFileNames: String...) {
        for soundFileName in soundFileNames {
            playSound(soundFileName: soundFileName)
        }
    }

    mutating func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully _: Bool) {
        if let index = duplicatePlayers.firstIndex(of: player) {
            duplicatePlayers.remove(at: index)
        }
    }
}
