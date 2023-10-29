//
//  MazeView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 25/10/23.
//

import ConfettiSwiftUI
import SpriteKit
import SwiftUI

struct MazeView: View {
    @StateObject private var scene: MazeScene = {
        let screenWidth = Screen.width
        let screenHeight = Screen.height
        let scene = MazeScene(
            size: CGSize(width: screenWidth, height: screenHeight)
        )
        scene.scaleMode = .fill

        return scene
    }()

    @State private var correctAnswer = false

    var onComplete: () -> Void = {}

    var body: some View {
        ZStack {
            SpriteView(scene: scene, options: [.allowsTransparency])
                .frame(width: Screen.width, height: Screen.height)
                .edgesIgnoringSafeArea(.all)
                .statusBar(hidden: true)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .ignoresSafeArea()
            VStack {
                Button("left") {
                    scene.move(.left)
                }
                Button("right") {
                    scene.move(.right)
                }
                Button("up") {
                    scene.move(.up)
                }
                Button("down") {
                    scene.move(.down)
                }
            }
        }.background(.ultraThinMaterial)
            .onChange(of: scene.correctAnswer) {
                correctAnswer = scene.correctAnswer
            }
            .popUp(isActive: $correctAnswer, withConfetti: true) {
                onComplete()
            }
    }
}

#Preview {
    MazeView {
        print("Done")
    }
}
