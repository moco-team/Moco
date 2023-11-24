//
//  Player.swift
//  Moco
//
//  Created by Daniel Aprillio on 22/11/23.
//

import Foundation
import SwiftUI

struct Player {
    let id: String
    let displayName: String
    let photo: Image?
    let leaderboard: Leaderboard

    public struct Leaderboard {
        let rank: Int
        let score: Int // Input total score
    }
}
