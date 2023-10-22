//
//  AudioModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 17/10/23.
//

import AVFoundation

struct AudioModel: Identifiable, Equatable {
    var players: [URL: AVAudioPlayer] = [:]
    var queuePlayers: [String: AVQueuePlayer] = [:]
    var playerVolumes: [URL: Float] = [:]
    var duplicatePlayers: [AVAudioPlayer] = []

    var volume: Float {
        players.first?.value.volume ?? 0
    }

    struct QueuePlayerParam {
        var fileName: String
        var type = "mp3"
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

    /// Play sounds in queue
    ///
    /// Usage Example
    ///
    /// `audioViewModel.playSoundsQueue(`
    /// `sounds: [`
    /// `.init(fileName: "Page1-monolog1", type: "m4a"),`
    /// `.init(fileName: "Page2-monolog1", type: "m4a"),`
    /// `.init(fileName: "Page3-monolog1", type: "m4a")],`
    /// `intervalDuration: 3)`
    ///
    /// This will play the songs with 3 seconds delay between songs
    mutating func playSoundsQueue(sounds: [QueuePlayerParam], intervalDuration: Double = 0, volume: Float = 1, id: String? = nil) {
        if let player = queuePlayers[id ?? ""] {
            player.volume = volume
            player.play()
            return
        }

        let urls = sounds.filter { sound in
            Bundle.main.path(forResource: sound.fileName, ofType: sound.type) != nil
        }.map { sound in
            let bundle = Bundle.main.path(forResource: sound.fileName, ofType: sound.type)
            return URL(fileURLWithPath: bundle!)
        }

        let playerItems = urls.map { AVPlayerItem(url: $0) }
        let player = AVQueuePlayer(items: playerItems)
        // Add a periodic time observer to check playback progress
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: nil) { _ in
            // Check if the player has reached the end of the current item
            if let currentItem = player.currentItem,
               currentItem.currentTime() >= currentItem.duration {
                // Pause the player
                player.pause()

                // Start a timer to wait for the interval duration
                Timer.scheduledTimer(withTimeInterval: intervalDuration, repeats: false) { _ in
                    // Resume playing after the interval
                    player.play()
                }
            }
        }
        player.volume = volume
        player.play()
        if id != nil {
            queuePlayers[id!] = player
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
