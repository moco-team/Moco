//
//  DetectionPromptViewModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 22/10/23.
//

import Foundation

@Observable class DetectionPromptViewModel {
    private var detectionPromptModel = DetectionPromptModel()

    var correctCount: Int {
        detectionPromptModel.correctCount
    }

    var showPopup: Bool {
        get {
            detectionPromptModel.showPopup
        }
        set {
            detectionPromptModel.showPopup = newValue
        }
    }

    func incCorrectCount() {
        detectionPromptModel.incrementCorrectCount()
    }
}
