//
//  ObjectDetectionViewModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 20/10/23.
//

import Foundation

class ObjectDetectionViewModel: ObservableObject {
    public static var shared: ObjectDetectionViewModel = .init()

    @Published private var objectDetectionModel = ObjectDetectionModel()

    var shouldStopSession: Bool {
        get {
            objectDetectionModel.shouldStopSession
        }
        set {
            objectDetectionModel.shouldStopSession = newValue
        }
    }

    var callback: (() -> Void)?

    var isMatch: Bool {
        objectDetectionModel.isMatch
    }

    func clear() {
        objectDetectionModel.clear()
    }

    func setTargetObject(_ values: [DetectionValue]) {
        objectDetectionModel.setTargetObject(values)
        if isMatch {
            callback?()
        }
    }

    func appendTargetObject(_ values: DetectionValue...) {
        objectDetectionModel.setTargetObject(values)
        if isMatch {
            callback?()
        }
    }

    func getTargetObject() -> [DetectionValue] {
        objectDetectionModel.getTargetObject()
    }

    func setDetectedObject(_ value: DetectionValue?) {
        objectDetectionModel.setDetectedObject(value)
    }

    func getDetectedObject() -> DetectionValue? {
        objectDetectionModel.getDetectedObject()
    }
}
