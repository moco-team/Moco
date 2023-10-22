//
//  DetectionPromptModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 22/10/23.
//

struct DetectionPromptModel {
    var showPopup = false
    private(set) var correctCount = 0

    mutating func incrementCorrectCount() {
        correctCount += 1
    }
}
