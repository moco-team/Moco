//
//  MazeView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 25/10/23.
//

import ConfettiSwiftUI
import SpriteKit
import SwiftUI

struct MazePuzzle {
    var correctAnswerAsset: String
    var answersAsset: [String]
    var question: String
    var action: (() -> Void)?
}

struct MazeView: View {
    @EnvironmentObject var motionViewModel: MotionViewModel
    @EnvironmentObject var orientationInfo: OrientationInfo

    var answersAsset = ["Maze/answer_one", "Maze/answer_two"]
    var correctAnswerAsset = "Maze/answer_three"

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
                .padding(.vertical, 12)
                .ignoresSafeArea()
                .frame(width: Screen.width, height: Screen.height)
        }
        .background(.ultraThinMaterial)
        .onAppear {
            motionViewModel.startUpdates()
            scene.correctAnswerAsset = correctAnswerAsset
            scene.wrongAnswerAsset = answersAsset
            print(correctAnswerAsset)
            TimerViewModel().setTimer(key: "mazeTimer\(correctAnswerAsset)", withInterval: 0.02) {
                motionViewModel.updateMotion()
                if orientationInfo.orientation == .landscapeLeft {
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
                } else if orientationInfo.orientation == .landscapeRight {
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
//            motionViewModel.stopUpdates()
            TimerViewModel().stopTimer()
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
