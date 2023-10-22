//
//  ObjectDetectionModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 20/10/23.
//

import Foundation

enum DetectionValue: String {
    case cellPhone = "cell phone"
    case person
    case chair
    case couch
    case bicycle
    case motorcycle
    case airplane
    case bus
    case train
}

struct ObjectDetectionModel {
    private var detectedObject: DetectionValue?
    private var targetObject: [DetectionValue] = []

    var isMatch: Bool {
        !targetObject.isEmpty && detectedObject != nil && targetObject.contains {
            $0 == detectedObject
        }
    }

    mutating func clear() {
        detectedObject = nil
        targetObject = []
    }

    mutating func setTargetObject(_ values: [DetectionValue]) {
        targetObject = values
    }

    mutating func appendTargetObject(_ values: DetectionValue...) {
        targetObject += values
    }

    func getTargetObject() -> [DetectionValue] {
        targetObject
    }

    mutating func setDetectedObject(_ value: DetectionValue?) {
        detectedObject = value
    }

    func getDetectedObject() -> DetectionValue? {
        detectedObject
    }
}
