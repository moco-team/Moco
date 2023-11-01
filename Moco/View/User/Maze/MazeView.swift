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
    @EnvironmentObject var motionViewModel: MotionViewModel
    @EnvironmentObject var orientationInfo: OrientationInfo

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
                .ignoresSafeArea()
                .frame(width: Screen.width, height: Screen.height)
        }
        .background(.ultraThinMaterial)
        .onAppear {
            motionViewModel.startUpdates()
            TimerViewModel().setTimer(key: "startTimer", withInterval: 0.02) {
                motionViewModel.updateMotion()
                if orientationInfo.orientation == .landscapeLeft{
                    if abs(motionViewModel.rollNum) > abs(motionViewModel.pitchNum) {
                        if motionViewModel.rollNum > 0 {
                            scene.move(.up)
                        } else if motionViewModel.rollNum < 0 {
                            scene.move(.down)
                        }
                    } else {
                        if motionViewModel.pitchNum > 0 {
                            scene.move(.right)
                        } else if motionViewModel.pitchNum < 0 {
                            scene.move(.left)
                        }
                    }
                } else if orientationInfo.orientation == .landscapeRight{
                    if abs(motionViewModel.rollNum) > abs(motionViewModel.pitchNum) {
                        if motionViewModel.rollNum > 0 {
                            scene.move(.down)
                        } else if motionViewModel.rollNum < 0 {
                            scene.move(.up)
                        }
                    } else {
                        if motionViewModel.pitchNum > 0 {
                            scene.move(.left)
                        } else if motionViewModel.pitchNum < 0 {
                            scene.move(.right)
                        }
                    }
                }
            }
        }
        .onDisappear {
            motionViewModel.stopUpdates()
        }
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
