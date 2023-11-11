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
    @Environment(\.timerViewModel) private var timerViewModel

    var answersAsset = ["Maze/answer_one", "Maze/answer_two"] {
        didSet {
            scene.wrongAnswerAsset = answersAsset
        }
    }

    var answers = ["satu", "dua", "tiga"]

    var correctAnswerAsset = "Maze/answer_three" {
        didSet {
            scene.correctAnswerAsset = correctAnswerAsset
        }
    }

    @State private var answersWidth: [Double] = [0, 0, 0]

    @StateObject private var scene: MazeScene = {
        let screenWidth = Screen.width
        let screenHeight = Screen.height
        let scene = MazeScene(
            size: CGSize(width: screenWidth, height: screenHeight * 0.7)
        )
        scene.scaleMode = .fill

        return scene
    }()

    @Binding var correctAnswer: Bool
    @Binding var wrongAnswer: Bool

    var onComplete: () -> Void = {}

    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                SpriteView(scene: scene, options: [.allowsTransparency])
                    .padding(.vertical, 12)
                    .ignoresSafeArea()
                    .frame(width: Screen.width, height: Screen.height * 0.7)
            }
            ZStack {
                if let obj1 = scene.obj01, scene.obj03 != nil {
                    Text(answers[0]).offset(x: obj1.position.x - answersWidth[0] / 2)
                        .customFont(.didactGothic, size: 30)
                        .foregroundColor(.text.brown)
                        .background {
                            GeometryReader {
                                proxy in
                                HStack {} // just an empty container to triggers the onAppear
                                    .onAppear {
                                        answersWidth[0] = proxy.size.width
                                    }
                            }
                        }
                }
                if let obj2 = scene.obj02, scene.obj03 != nil {
                    Text(answers[1]).offset(x: obj2.position.x - answersWidth[1] / 2)
                        .customFont(.didactGothic, size: 30)
                        .foregroundColor(.text.brown)
                        .background {
                            GeometryReader {
                                proxy in
                                HStack {} // just an empty container to triggers the onAppear
                                    .onAppear {
                                        answersWidth[1] = proxy.size.width
                                    }
                            }
                        }
                }
                if let obj3 = scene.obj03, scene.obj03 != nil {
                    Text(answers[2]).offset(x: obj3.position.x - answersWidth[2] / 2)
                        .customFont(.didactGothic, size: 30)
                        .foregroundColor(.text.brown)
                        .background {
                            GeometryReader {
                                proxy in
                                HStack {} // just an empty container to triggers the onAppear
                                    .onAppear {
                                        answersWidth[2] = proxy.size.width
                                    }
                            }
                        }
                }
            }
        }
        .background(.clear)
        .onLoad {
            motionViewModel.startUpdates()
            scene.correctAnswerAsset = correctAnswerAsset
            scene.wrongAnswerAsset = answersAsset
            timerViewModel.stopTimer("mazeTimer\(correctAnswerAsset)")
            timerViewModel.setTimer(key: "mazeTimer\(correctAnswerAsset)", withInterval: 5) {
                print("wasu")
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
            timerViewModel.stopTimer("mazeTimer\(correctAnswerAsset)")
        }
        .onChange(of: scene.correctAnswer) {
            if let sceneCorrectAnswer = scene.correctAnswer {
                correctAnswer = sceneCorrectAnswer
            }
        }
        .onChange(of: scene.wrongAnswer) {
            if let sceneWrongAnswer = scene.wrongAnswer {
                wrongAnswer = sceneWrongAnswer
            }
        }
    }
}

#Preview {
    MazeView(correctAnswer: .constant(true), wrongAnswer: .constant(false)) {
        print("Done")
    }
}
