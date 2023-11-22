//
//  GameCenterView.swift
//  Moco
//
//  Created by Daniel Aprillio on 22/11/23.
//

import SwiftUI
import GameKit

public struct GameCenterView: UIViewControllerRepresentable {
    let viewController: GKGameCenterViewController

    public init(viewState: GKGameCenterViewControllerState) {
        viewController = GKGameCenterViewController(state: viewState)
    }

    public func makeCoordinator() -> GameCenterCoordinator {
        return GameCenterCoordinator(self)
    }

    public func makeUIViewController(context: Context) -> GKGameCenterViewController {
        let gameCenterViewController = viewController
        gameCenterViewController.gameCenterDelegate = context.coordinator
        return gameCenterViewController
    }

    public func updateUIViewController(_: GKGameCenterViewController, context _: Context) {}
}

public class GameCenterCoordinator: NSObject, GKGameCenterControllerDelegate {
    let view: GameCenterView

    init(_ view: GameCenterView) {
        self.view = view
    }

    public func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true)
    }
}

struct GameCenterView_Previews: PreviewProvider {
    static var previews: some View {
        GameCenterView(viewState: .default)
            .ignoresSafeArea()
    }
}

