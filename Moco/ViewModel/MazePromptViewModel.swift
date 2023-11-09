//
//  MazePromptViewModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 30/10/23.
//

import SwiftUI

@Observable class MazePromptViewModel {
    private var mazePromptModel = MazePromptModel()

    var isTutorialDone = GlobalStorage.mazeTutorialFinished

    var isStarted: Bool {
        mazePromptModel.isStarted
    }

    var blurOpacity: Double {
        mazePromptModel.blurOpacity
    }

    var showStartButton: Bool {
        mazePromptModel.showStartButton
    }

    var progress: Double {
        set {
            mazePromptModel.progress = newValue
        }
        get {
            mazePromptModel.progress + 0.5
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
