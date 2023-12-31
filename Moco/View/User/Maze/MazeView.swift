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
    @Environment(\.mazePromptViewModel) private var mazePromptViewModel

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
            size: CGSize(width: screenWidth, height: screenHeight * (UIDevice.isIPad ? 0.7 : 0.6))
        )
        scene.scaleMode = .fill

        return scene
    }()

    var onComplete: () -> Void = {}

    var fontSize: CGFloat {
        UIDevice.isIPad ? 25 : 15
    }

    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                SpriteView(scene: scene, options: [.allowsTransparency])
                    .padding(.vertical, UIDevice.isIPad ? 5 : 0)
                    .ignoresSafeArea()
                    .frame(width: Screen.width, height: Screen.height * (UIDevice.isIPad ? 0.7 : 0.6))
            }
            ZStack {
                if let obj1 = scene.obj01, scene.obj03 != nil {
                    Text(answers[0]).offset(x: obj1.position.x - answersWidth[0] / 2)
                        .customFont(.didactGothic, size: fontSize)
                        .foregroundColor(.text.brown)
                        .background {
                            GeometryReader {
                                proxy in
                                HStack {} // just an empty container to triggers the onAppear
                                    .task {
                                        answersWidth[0] = proxy.size.width
                                    }
                            }
                        }
                }
                if let obj2 = scene.obj02, scene.obj03 != nil {
                    Text(answers[1]).offset(x: obj2.position.x - answersWidth[1] / 2)
                        .customFont(.didactGothic, size: fontSize)
                        .foregroundColor(.text.brown)
                        .background {
                            GeometryReader {
                                proxy in
                                HStack {} // just an empty container to triggers the onAppear
                                    .task {
                                        answersWidth[1] = proxy.size.width
                                    }
                            }
                        }
                }
                if let obj3 = scene.obj03, scene.obj03 != nil {
                    Text(answers[2]).offset(x: obj3.position.x - answersWidth[2] / 2)
                        .customFont(.didactGothic, size: fontSize)
                        .foregroundColor(.text.brown)
                        .background {
                            GeometryReader {
                                proxy in
                                HStack {} // just an empty container to triggers the onAppear
                                    .task {
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
        }
        .onChange(of: scene.correctAnswer) {
            if let sceneCorrectAnswer = scene.correctAnswer {
                mazePromptViewModel.isCorrectAnswer = sceneCorrectAnswer
            }
        }
        .onChange(of: scene.wrongAnswer) {
            if let sceneWrongAnswer = scene.wrongAnswer {
                mazePromptViewModel.isWrongAnswer = sceneWrongAnswer
            }
        }
    }

    private func landscapeLeftControl() {
        if abs(motionViewModel.rollNum) > abs(motionViewModel.pitchNum) {
            if motionViewModel.rollNum > 0 {
                switch motionViewModel.gravityDegree {
                case -75 ... -10, 10 ... 80:
                    scene.move(.right)
                case 100 ... 170, 190 ... 255:
                    scene.move(.left)
                default:
                    scene.move(.up)
                }
            } else if motionViewModel.rollNum < 0 {
                switch motionViewModel.gravityDegree {
                case -75 ... -10, 105 ... 170:
                    scene.move(.right)
                case 10 ... 75, 190 ... 255:
                    scene.move(.left)
                default:
                    scene.move(.down)
                }
            }
        } else {
            if motionViewModel.pitchNum > 0 {
                scene.move(.right)
            } else if motionViewModel.pitchNum < 0 {
                scene.move(.left)
            }
        }
    }

    private func landscapeRightControl() {
        if abs(motionViewModel.rollNum) > abs(motionViewModel.pitchNum) {
            if motionViewModel.rollNum > 0 {
                switch motionViewModel.gravityDegree {
                case -75 ... -10, 105 ... 170:
                    scene.move(.right)
                case 10 ... 75, 190 ... 255:
                    scene.move(.left)
                default:
                    scene.move(.down)
                }
            } else if motionViewModel.rollNum < 0 {
                switch motionViewModel.gravityDegree {
                case -75 ... -10, 10 ... 80:
                    scene.move(.left)
                case 100 ... 170, 190 ... 255:
                    scene.move(.right)
                default:
                    scene.move(.up)
                }
            }
        } else {
            if motionViewModel.pitchNum > 0 {
                scene.move(.left)
            } else if motionViewModel.pitchNum < 0 {
                scene.move(.right)
            }
        }
    }

    private func updateMazeControl() {
        guard mazePromptViewModel.isTutorialDone else { return }
        motionViewModel.updateMotion()
        if orientationInfo.orientation == .landscapeLeft {
            landscapeLeftControl()
        } else if orientationInfo.orientation == .landscapeRight {
            landscapeRightControl()
        }
    }
}

struct MazeViewPreview: View {
    var body: some View {
        MazeView {
            print("Done")
        }
        .environment(\.mazePromptViewModel, MazePromptViewModel.shared)
        .environmentObject(MotionViewModel())
        .environmentObject(OrientationInfo.shared)
    }
}

#Preview {
    MazeViewPreview()
}
