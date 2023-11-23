//
//  AudioModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 17/10/23.
//

import AVFoundation

enum AudioCategory: Equatable, Hashable {
    case narration
    case backsound
    case soundEffect
}

enum AudioType: String, Equatable, Hashable {
    case mp3
    case m4a
    case wav
}

protocol AVPlayerWithVolume {
    // Define anything in common between objects
    // Example:
    var volume: Float { get set }
    func setVolume(_ volume: Float, fadeDuration duration: TimeInterval)
    var isPlaying: Bool { get } /* is it playing or not? */
}

extension AVAudioPlayer: AVPlayerWithVolume {}
extension AVQueuePlayer: AVPlayerWithVolume {
    func setVolume(_ volume: Float, fadeDuration _: TimeInterval) {
        self.volume = volume
    }

    var isPlaying: Bool { true }
}

struct PlayersByCategory: Equatable {
    var narration: [any AVPlayerWithVolume] = []
    var backsound: [any AVPlayerWithVolume] = []
    var soundEffect: [any AVPlayerWithVolume] = []

    static func == (lhs: PlayersByCategory, rhs: PlayersByCategory) -> Bool {
        return lhs.narration.first?.volume == rhs.narration.first?.volume &&
            lhs.backsound.first?.volume == rhs.backsound.first?.volume &&
            lhs.soundEffect.first?.volume == rhs.soundEffect.first?.volume
    }
}

struct AudioModel: Identifiable, Equatable {
    var players: [URL: AVAudioPlayer] = [:]
    var playerCategories: [URL: AudioCategory] = [:]
    var queuePlayers: [String: AVQueuePlayer] = [:]
    var playerVolumes: [URL: Float] = [:]
    var queuePlayerVolumes: [String: Float] = [:]
    var duplicatePlayers: [AVAudioPlayer] = []
    var playersByCategory = PlayersByCategory()

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
        setVolumeQueue(0, writePlayerVolumes: false)
    }

    mutating func unmute() {
        setVolume(nil, fadeDuration: 1)
        setVolumeQueue(nil)
    }

    mutating func setVolume(_ volume: Float?, writePlayerVolumes: Bool = true, fadeDuration: TimeInterval = 0) {
        players.forEach { _, value in
            setVolume(volume, player: value, writePlayerVolumes: writePlayerVolumes, fadeDuration: fadeDuration)
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

    mutating func setVolume(
        _ volume: Float?,
        player: AVAudioPlayer,
        writePlayerVolumes: Bool = true,
        fadeDuration: TimeInterval = 0
    ) {
        if let playerURL = player.url {
            if volume != nil && writePlayerVolumes {
                playerVolumes[playerURL] = volume
            }
            player.setVolume(volume ?? (playerVolumes[playerURL] ?? 0), fadeDuration: fadeDuration)
        } else {
            player.setVolume(volume ?? 1, fadeDuration: fadeDuration)
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

    func getGlobalVolume(_ category: AudioCategory?, volume: Float) -> Float {
        var parsedVolume: Float
        switch category {
        case .backsound:
            parsedVolume = Float(GlobalStorage.backsoundVolume)
        case .narration:
            parsedVolume = Float(GlobalStorage.narrationVolume)
        case .soundEffect:
            parsedVolume = Float(GlobalStorage.soundEffectVolume)
        case .none:
            parsedVolume = volume
        }
        return parsedVolume
    }

    mutating func setPlayerByCategory(_ player: AVPlayerWithVolume, category: AudioCategory?, url: URL? = nil) {
        switch category {
        case .backsound:
            playersByCategory.backsound.append(player)
        case .narration:
            playersByCategory.narration.append(player)
        case .soundEffect:
            playersByCategory.soundEffect.append(player)
        case .none:
            break
        }
        if let url = url {
            playerCategories[url] = category
        }
    }

    mutating func setVolumeByCategory(_ volume: Float, category: AudioCategory) {
        switch category {
        case .backsound:
            for index in playersByCategory.backsound.indices {
                playersByCategory.backsound[index].volume = volume
            }
        case .narration:
            for index in playersByCategory.narration.indices {
                playersByCategory.narration[index].volume = volume
            }
        case .soundEffect:
            for index in playersByCategory.soundEffect.indices {
                playersByCategory.soundEffect[index].volume = volume
            }
        }
    }

    mutating func playSound(
        soundFileName: String,
        type: String = "mp3",
        numberOfLoops: Int = 0,
        volume: Float = 1,
        category: AudioCategory? = nil
    ) -> AVAudioPlayer {
        guard let bundle = Bundle.main.path(forResource: soundFileName, ofType: type) else {
            print("SOUND NOT FOUND, check the bundle resources")
            return AVAudioPlayer()
        }
        let soundFileNameURL = URL(fileURLWithPath: bundle)

        if let player = players[soundFileNameURL] { // player for sound has been found
            if !player.isPlaying { // player is not in use, so use that one
                player.numberOfLoops = numberOfLoops
                let parsedVolume = getGlobalVolume(category, volume: volume)
                setVolume(parsedVolume, player: player)
                player.prepareToPlay()
                player.play()
            }
            setPlayerByCategory(player, category: category, url: player.url)
            if category == .narration {
                for player in playersByCategory.backsound {
                    player.setVolume(0, fadeDuration: 0.5)
                }
            } else if category == .backsound {
                if playersByCategory.narration.contains(where: { $0.isPlaying }) {
                    player.setVolume(0, fadeDuration: 0.5)
                }
            }
            return player
        } else { // player has not been found, create a new player with the URL if possible
            do {
                let player = try AVAudioPlayer(contentsOf: soundFileNameURL)
                players[soundFileNameURL] = player
                player.numberOfLoops = numberOfLoops
                let parsedVolume = getGlobalVolume(category, volume: volume)
                setVolume(parsedVolume, player: player)
                player.prepareToPlay()
                player.play()
                setPlayerByCategory(player, category: category, url: player.url)
                if category == .narration {
                    for player in playersByCategory.backsound {
                        player.setVolume(0, fadeDuration: 0.5)
                    }
                } else if category == .backsound {
                    if playersByCategory.narration.contains(where: { $0.isPlaying }) {
                        player.setVolume(0, fadeDuration: 0.5)
                    }
                }
                return player
            } catch {
                print(error.localizedDescription)
            }
        }
        return AVAudioPlayer()
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
    mutating func playSoundsQueue(sounds: [QueuePlayerParam], intervalDuration: Double = 0, volume: Float = 1, id: String? = nil, category: AudioCategory? = nil) {
        if let player = queuePlayers[id ?? ""] {
            let parsedVolume = getGlobalVolume(category, volume: volume)
            player.volume = parsedVolume
            player.play()
            setPlayerByCategory(player, category: category)
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
        setPlayerByCategory(player, category: category)
    }

    mutating func setVolumeQueue(_ volume: Float?, writePlayerVolumes: Bool = true) {
        queuePlayers.forEach { key, value in
            setVolumeQueue(volume, player: value, playerId: key, writePlayerVolumes: writePlayerVolumes)
        }
    }

    mutating func setVolumeQueue(_ volume: Float?, playerId: String, writePlayerVolumes: Bool = true) {
        if let player = queuePlayers[playerId] {
            setVolumeQueue(volume, player: player, writePlayerVolumes: writePlayerVolumes)
        }
    }

    mutating func setVolumeQueue(
        _ volume: Float?,
        player: AVQueuePlayer,
        playerId: String? = nil,
        writePlayerVolumes: Bool = true
    ) {
        if playerId != nil {
            if volume != nil && writePlayerVolumes {
                queuePlayerVolumes[playerId!] = volume
            }
            player.volume = volume ?? (queuePlayerVolumes[playerId!] ?? 0)
        } else {
            player.volume = volume ?? 1
        }
    }

    func stopSoundsQueue(id: String) {
        if let player = queuePlayers[id] { // player for sound has been found
            player.pause()
            player.seek(to: .zero)
        }
    }

    func stopAllSoundsQueue() {
        queuePlayers.forEach { _, player in
            player.pause()
            player.seek(to: .zero)
        }
    }

    func pauseAllSoundsQueue() {
        queuePlayers.forEach { _, player in
            player.pause()
        }
    }

    mutating func clearAll() {
        queuePlayers.forEach { _, player in
            player.removeAllItems()
        }
        stopAllSounds()
        players = [:]
        queuePlayers = [:]
        playerVolumes = [:]
        queuePlayerVolumes = [:]
        duplicatePlayers = []
        playerCategories = [:]
        playersByCategory = PlayersByCategory()
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

    func pauseAllSounds(_ category: AudioCategory? = nil) {
        players.forEach { _, value in
            if let nonNilCategory = category, let playerUrl = value.url {
                let playerCategory = playerCategories[playerUrl]
                if playerCategory == nonNilCategory {
                    value.stop()
                }
            } else {
                value.stop()
            }
        }
    }

    mutating func playSounds(soundFileNames: [String]) {
        soundFileNames.forEach { name in
            _ = playSound(soundFileName: name)
        }
    }

    mutating func playSounds(soundFileNames: String...) {
        soundFileNames.forEach { name in
            _ = playSound(soundFileName: name)
        }
    }

    mutating func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully _: Bool) {
        if let url = player.url {
            if let category = playerCategories[url], category == .narration {
                if !playersByCategory.narration.contains(where: { $0.isPlaying }) {
                    unmute()
                }
            }
        }
        if let index = duplicatePlayers.firstIndex(of: player) {
            duplicatePlayers.remove(at: index)
        }
    }
}
