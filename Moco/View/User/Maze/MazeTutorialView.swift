//
//  MazeTutorialView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 07/11/23.
//

import SwiftUI

enum MazeTutorialPhase {
    case right
    case left
    case up
    case down
}

struct MazeTutorialView: View {
    @EnvironmentObject var motionViewModel: MotionViewModel
    @EnvironmentObject var orientationInfo: OrientationInfo
    @Environment(\.mazePromptViewModel) private var mazePromptViewModel
    @Environment(\.audioViewModel) private var audioViewModel
    @Environment(\.timerViewModel) private var timerViewModel

    @State private var rightProgress = 0
    @State private var leftProgress = 0
    @State private var downProgress = 0
    @State private var upProgress = 0
    @State private var currentPhase = MazeTutorialPhase.right
    @State private var showTutorialCompletePrompt = false
    @State private var isDone = false

    var currentProgress: Int {
        get {
            switch currentPhase {
            case .right:
                return rightProgress
            case .left:
                return leftProgress
            case .up:
                return upProgress
            case .down:
                return downProgress
            }
        }
        set {
            switch currentPhase {
            case .right:
                rightProgress = newValue
            case .left:
                leftProgress = newValue
            case .up:
                upProgress = newValue
            case .down:
                downProgress = newValue
            }
        }
    }

    var currentInstruction: String {
        switch currentPhase {
        case .right:
            return "kanan"
        case .left:
            return "kiri"
        case .up:
            return "atas"
        case .down:
            return "bawah"
        }
    }

    func done() {
        withAnimation {
            isDone = true
        } completion: {
            mazePromptViewModel.isTutorialDone = true
        }
    }

    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
            VStack {
                GIFView(type: .name("gyro"))
                    .frame(width: 200, height: 200)
                    .padding(.horizontal)
                    .padding(.top, -75)
                    .frame(width: 280, alignment: .center)
                Text("Miringkan perangkat ke \(currentInstruction)")
                    .customFont(.didactGothic, size: 30)
                    .foregroundColor(.white)
                    .padding()
                CircularProgressView(progress: Double(currentProgress) / 100.0, size: 60, width: 10) {
                    progress in
                    Text("\(progress * 100, specifier: "%.0f")%")
                        .customFont(.didactGothic, size: 20)
                        .foregroundColor(.white)
                        .bold()
                }
            }
        }
        .onAppear {
            motionViewModel.startUpdates()
            timerViewModel.stopTimer("mazeTutorialTimer")
            timerViewModel.setTimer(key: "mazeTutorialTimer", withInterval: 0.02) {
                motionViewModel.updateMotion()
                if currentProgress < 100 {
                    if orientationInfo.orientation == .landscapeLeft {
                        if abs(motionViewModel.rollNum) > abs(motionViewModel.pitchNum) {
                            if motionViewModel.rollNum > 0 && currentPhase == .up {
                                upProgress += 1
                            } else if motionViewModel.rollNum < 0 && currentPhase == .down {
                                downProgress += 1
                            }
                        } else {
                            if motionViewModel.pitchNum > 0 && currentPhase == .right {
                                rightProgress += 1
                            } else if motionViewModel.pitchNum < 0 && currentPhase == .left {
                                leftProgress += 1
                            }
                        }
                    } else if orientationInfo.orientation == .landscapeRight {
                        if abs(motionViewModel.rollNum) > abs(motionViewModel.pitchNum) {
                            if motionViewModel.rollNum > 0 && currentPhase == .down {
                                downProgress += 1
                            } else if motionViewModel.rollNum < 0 && currentPhase == .up {
                                upProgress += 1
                            }
                        } else {
                            if motionViewModel.pitchNum > 0 && currentPhase == .left {
                                leftProgress += 1
                            } else if motionViewModel.pitchNum < 0 && currentPhase == .right {
                                rightProgress += 1
                            }
                        }
                    }
                } else if currentProgress >= 100 {
                    switch currentPhase {
                    case .right:
                        currentPhase = .left
                        audioViewModel.playSound(
                            soundFileName: "010 (maze) - coba miringkan layar ke kiri",
                            type: "m4a",
                            category: .narration
                        )
                    case .left:
                        currentPhase = .up
                        audioViewModel.playSound(
                            soundFileName: "011 (maze) - coba miringkan layar ke atas",
                            type: "m4a",
                            category: .narration
                        )
                    case .up:
                        currentPhase = .down
                        audioViewModel.playSound(
                            soundFileName: "012 (maze) - coba miringkan layar ke bawah",
                            type: "m4a",
                            category: .narration
                        )
                    case .down:
                        if !showTutorialCompletePrompt && !isDone {
                            showTutorialCompletePrompt = true
                        }
                    }
                }
            }
        }
        .opacity(isDone ? 0 : 1)
        .onDisappear {
            timerViewModel.stopTimer("mazeTutorialTimer")
        }
        .onAppear {
            audioViewModel.playSound(
                soundFileName: "009 (maze) - coba miringkan layar ke kanan",
                type: "m4a",
                category: .narration
            )
        }
        .ignoresSafeArea()
        .frame(width: Screen.width, height: Screen.height)
        .popUp(
            isActive: $showTutorialCompletePrompt,
            title: "Selamat kamu berhasil menyelesaikan tutorial",
            withConfetti: true,
            closeWhenDone: true
        ) {
            done()
        } cancelHandler: {
            done()
        }
    }
}

#Preview {
    MazeTutorialView()
}
