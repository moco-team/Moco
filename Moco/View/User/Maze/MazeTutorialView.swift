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

    @State private var rightProgress = 0
    @State private var leftProgress = 0
    @State private var downProgress = 0
    @State private var upProgress = 0
    @State private var currentPhase = MazeTutorialPhase.right

    var currentProgress: Int {
        get {
            switch (currentPhase) {
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
            switch (currentPhase) {
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
        switch (currentPhase) {
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

    var body: some View {
        VStack {
            Text("Tutorial Maze Asu")
            Spacer()
            Text("Miringkan layar ke \(currentInstruction)")
            CircularProgressView(progress: Double(currentProgress) / 100.0, size: 60, width: 10) {
                progress in
                Text("\(progress * 100, specifier: "%.0f")%")
                    .customFont(.didactGothic, size: 20)
                    .bold()
            }
            Spacer()
        }
        .onAppear {
            motionViewModel.startUpdates()
            TimerViewModel().setTimer(key: "mazeTutorialTimer", withInterval: 0.02) {
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
                    switch (currentPhase) {
                    case .right:
                        currentPhase = .left
                    case .left:
                        currentPhase = .up
                    case .up:
                        currentPhase = .down
                    default:
                        break
                    }
                }
            }
        }
        .ignoresSafeArea()
        .frame(width: Screen.width, height: Screen.height)
    }
}

#Preview {
    MazeTutorialView()
}
