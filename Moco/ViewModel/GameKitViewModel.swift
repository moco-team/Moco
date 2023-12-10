//
//  GameKitViewModel.swift
//  Moco
//
//  Created by Daniel Aprillio on 22/11/23.
//

import Foundation
import GameKit
import SwiftUI

@Observable class GameKitViewModel: NSObject, GKLocalPlayerListener {
    var playerModel = PlayerViewModel.shared

    static var shared = GameKitViewModel()

    override init() {
        super.init()

        authenticateUser { [self] success in
            if success {
//                self.reportScore(score: score)
            }
        }
    }

    func authenticateUser(completion: @escaping (Bool) -> Void) {
        playerModel.localPlayer.authenticateHandler = { [self] _, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                completion(false)
                return
            }

            // Turn off Game Kit Active Indicator
            GKAccessPoint.shared.isActive = false

            if playerModel.localPlayer.isAuthenticated {
                playerModel.localPlayer.register(self)
                completion(true)
            }
        }
    }

    func reportScore(score: Int) {
        if playerModel.localPlayer.isAuthenticated {
            GKLeaderboard.submitScore(
                score,
                context: 0,
                player: playerModel.localPlayer,
                leaderboardIDs: [LeaderboardID.score]
            ) { error in
                print("Leaderboard Submit Score Error:")
                if let errorText = error?.localizedDescription {
                    print(errorText)
                }
            }
            print("Score submitted: \(score)")
        }
    }

    func reportAchievement(achievementID: String, percentComplete: Double) {
        if playerModel.localPlayer.isAuthenticated {
            let achievement = GKAchievement(identifier: achievementID)
            achievement.percentComplete = percentComplete
            achievement.showsCompletionBanner = true

            GKAchievement.report([achievement]) { error in
                if let error = error {
                    print("Failed to report achievement: \(error.localizedDescription)")
                } else {
                    print("Achievement reported successfully!")
                }
            }
        }
    }
}
