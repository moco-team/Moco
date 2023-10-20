//
//  ObjectDetectionModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 20/10/23.
//

import Foundation

enum DetectionValue: String {
    case phone
    case person
}

struct ObjectDetectionModel {
    private var detectedObject: DetectionValue?
    private var targetObject: DetectionValue?

    var isMatch: Bool {
        targetObject != nil && detectedObject == targetObject
    }

    mutating func clear() {
        detectedObject = nil
        targetObject = nil
    }

    mutating func setTargetObject(_ value: DetectionValue?) {
        targetObject = value
    }

    func getTargetObject() -> DetectionValue? {
        return targetObject
    }

    mutating func setDetectedObject(_ value: DetectionValue?) {
        detectedObject = value
    }

    func getDetectedObject() -> DetectionValue? {
        return detectedObject
    }
}
