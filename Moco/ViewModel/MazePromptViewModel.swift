//
//  MazePromptViewModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 30/10/23.
//

import SwiftUI

@Observable class MazePromptViewModel {
    static var shared = MazePromptViewModel()

    private var mazePromptModel = MazePromptModel()
    private var audioViewModel = AudioViewModel.shared

    var isTutorialDone: Bool {
        get {
            GlobalStorage.mazeTutorialFinished
        }
        set {
            GlobalStorage.mazeTutorialFinished = newValue
            mazePromptModel.isTutorialDone = newValue
        }
    }

    var isStarted: Bool {
        mazePromptModel.isStarted
    }

    var blurOpacity: Double {
        mazePromptModel.blurOpacity
    }

    var showStartButton: Bool {
        mazePromptModel.showStartButton
    }

    func reset(_ all: Bool = false) {
        mazePromptModel.reset(all)
    }

    func incWrong() {
        mazePromptModel.wrongCount += 1
    }

    var progress: Double {
        set {
            mazePromptModel.progress = newValue
        }
        get {
            Double(max(mazePromptModel.currentMazeIndex - mazePromptModel.wrongCount, 0)) /
                Double(mazePromptModel.mazeCount == 0 ? 1 : mazePromptModel.mazeCount)
        }
    }

    var mazeCount: Int {
        set {
            mazePromptModel.mazeCount = newValue
        }
        get {
            mazePromptModel.mazeCount
        }
    }

    var currentMazeIndex: Int {
        set {
            mazePromptModel.currentMazeIndex = newValue
            if mazeCount > -1 && currentMazeIndex >= mazeCount {
                audioViewModel.playSound(
                    soundFileName: "008 (maze) - wah, kamu baik sekali yaa.. mau membantu Moco menemukan Teka dan Teki",
                    type: .m4a,
                    category: .narration
                )
            }
        }
        get {
            mazePromptModel.currentMazeIndex
        }
    }

    var isCorrectAnswer: Bool {
        set {
            mazePromptModel.isCorrectAnswer = newValue
        }
        get {
            mazePromptModel.isCorrectAnswer
        }
    }

    var isWrongAnswer: Bool {
        set {
            mazePromptModel.isWrongAnswer = newValue
        }
        get {
            mazePromptModel.isWrongAnswer
        }
    }

    func playPrompt() {
        mazePromptModel.isStarted = false
        withAnimation(.easeInOut(duration: 3)) {
            mazePromptModel.blurOpacity = 1
        } completion: {
            withAnimation(.easeInOut.delay(2)) {
                self.mazePromptModel.showStartButton = true
            }
        }
    }

    func stopPrompt() {
        withAnimation(.easeInOut(duration: 2)) {
            mazePromptModel.blurOpacity = 0
            mazePromptModel.showStartButton = false
        } completion: {
            withAnimation {
                self.mazePromptModel.isStarted = true
            }
        }
    }
}
