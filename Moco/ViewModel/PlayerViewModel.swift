//
//  PlayerViewModel.swift
//  Moco
//
//  Created by Daniel Aprillio on 22/11/23.
//

import Foundation
import GameKit
import SwiftUI

class PlayerViewModel: ObservableObject {
    @Published var localPlayer = GKLocalPlayer.local

    // Create as a Singleton to avoid more than one instance.
    public static var shared: PlayerViewModel = .init()

    private(set) lazy var isAuthenticated: Bool = localPlayer.isAuthenticated
}
