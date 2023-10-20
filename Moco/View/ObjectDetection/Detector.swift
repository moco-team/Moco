//
//  Detector.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 11/10/23.
//

import AVFoundation
import UIKit
import Vision

extension ObjectDetectionViewController {
    func setupDetector() {
        let modelURL = Bundle.main.url(forResource: "yolov8s", withExtension: "mlmodelc")

        do {
            let visionModel = try VNCoreMLModel(for: MLModel(contentsOf: modelURL!))
            let recognitions = VNCoreMLRequest(model: visionModel, completionHandler: detectionDidComplete)
            requests = [recognitions]
        } catch {
            print(error)
        }
    }

    func detectionDidComplete(request: VNRequest, error _: Error?) {
        DispatchQueue.main.async {
            if let results = request.results {
                self.extractDetections(results)
            }
        }
    }

    func extractDetections(_ results: [VNObservation]) {
        detectionLayer.sublayers = nil

        for observation in results where observation is VNRecognizedObjectObservation {
            guard let objectObservation = observation as? VNRecognizedObjectObservation else { continue }
            guard objectObservation.confidence > threshold else { continue }

            // Transformations
            let objectBounds = VNImageRectForNormalizedRect(objectObservation.boundingBox, Int(screenRect.size.width), Int(screenRect.size.height))
            let transformedBounds = CGRect(
                x: objectBounds.minX,
                y: screenRect.size.height - objectBounds.maxY,
                width: objectBounds.maxX - objectBounds.minX,
                height: objectBounds.maxY - objectBounds.minY
            )

            let boxLayer = self.drawBoundingBox(transformedBounds)

            let textlayer = CATextLayer()

            textlayer.frame = CGRect(x: objectBounds.minX,
                                     y: screenRect.size.height - objectBounds.maxY + 10, width: 200, height: 18)
            textlayer.fontSize = 12
            textlayer.alignmentMode = .center
            textlayer.string = objectObservation.labels[0].identifier
            textlayer.isWrapped = true
            textlayer.truncationMode = .end
            textlayer.backgroundColor = UIColor.white.cgColor
            textlayer.foregroundColor = UIColor.black.cgColor

            detectionLayer.addSublayer(boxLayer)
            detectionLayer.addSublayer(textlayer)
            
            detectionHandler?(objectObservation.labels[0].identifier)
        }
    }

    func setupLayers() {
        detectionLayer = CALayer()
        detectionLayer.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
        view.layer.addSublayer(detectionLayer)
    }

    func updateLayers() {
        detectionLayer?.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
    }

    func drawBoundingBox(_ bounds: CGRect) -> CALayer {
        let boxLayer = CALayer()
        boxLayer.frame = bounds
        boxLayer.borderWidth = 3.0
        boxLayer.borderColor = CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        boxLayer.cornerRadius = 4
        return boxLayer
    }

    func captureOutput(_: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from _: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .up, options: [:])
        // Create handler to perform request on the buffer

        do {
            try imageRequestHandler.perform(requests) // Schedules vision requests to be performed
        } catch {
            print(error)
        }
    }
}
