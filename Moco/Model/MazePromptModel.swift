//
//  MazePromptModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 30/10/23.
//

import Foundation

struct MazePromptModel {
    var blurOpacity = 0.0
    var showStartButton = false
    var isStarted = false
    var progress = 0.0
    var isCorrectAnswer: Bool = false
    var isWrongAnswer: Bool = false
    var isTutorialDone = GlobalStorage.mazeTutorialFinished
    var mazeCount = -1
    var currentMazeIndex = 0

    var wrongCount = 0
    var durationInSeconds = 60 * 3

    mutating func reset(_ all: Bool = false) {
        blurOpacity = 0.0
        showStartButton = false
        isStarted = false
        progress = 0.0
        isCorrectAnswer = false
        isWrongAnswer = false
        isTutorialDone = GlobalStorage.mazeTutorialFinished
        mazeCount = -1
        currentMazeIndex = 0
        if all {
            wrongCount = 0
            durationInSeconds = 60 * 3
        }
    }
}
