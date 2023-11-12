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
}
