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

    var callback: (() -> Void)?

    var isMatch: Bool {
        objectDetectionModel.isMatch
    }

    func clear() {
        objectDetectionModel.clear()
    }

    func setTargetObject(_ value: DetectionValue?) {
        objectDetectionModel.setTargetObject(value)
        if isMatch {
            callback?()
        }
    }

    func getTargetObject() -> DetectionValue? {
        return objectDetectionModel.getTargetObject()
    }

    func setDetectedObject(_ value: DetectionValue?) {
        guard value == objectDetectionModel.getTargetObject() else { return }
        objectDetectionModel.setDetectedObject(value)
    }

    func getDetectedObject() -> DetectionValue? {
        return objectDetectionModel.getDetectedObject()
    }
}
