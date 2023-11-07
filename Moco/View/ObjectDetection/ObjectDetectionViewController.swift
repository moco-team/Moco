//
//  ObjectDetectionViewController.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 11/10/23.
//

import AVFoundation
import SwiftUI
import UIKit
import Vision

class ObjectDetectionViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    private var permissionGranted = false // Flag for permission
    private let captureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "sessionQueue")
    private var previewLayer = AVCaptureVideoPreviewLayer()
    var screenRect: CGRect! = nil // For view dimensions

    var objectDetectionViewModel: ObjectDetectionViewModel?
    var detectionHandler: ((String?) -> Void)?
    var threshold: Float = 0.8

    // Detector
    private var videoOutput = AVCaptureVideoDataOutput()
    var requests = [VNRequest]()
    var detectionLayer: CALayer! = nil

    override func viewDidLoad() {
        checkPermission()

        sessionQueue.async { [unowned self] in
            guard permissionGranted else { return }
            self.setupCaptureSession()

            self.setupLayers()
            self.setupDetector()

            self.captureSession.startRunning()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        stopSession()
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        stopSession()
        super.viewDidDisappear(animated)
    }

    func stopSession() {
        if captureSession.isRunning {
            sessionQueue.async { [weak self] in
                self?.captureSession.stopRunning()
            }
        }
    }

    func setOrientation() {
        switch UIDevice.current.orientation {
        // Home button on top
        case UIDeviceOrientation.portraitUpsideDown:
            previewLayer.connection?.videoOrientation = .portrait

        // Home button on right
        case UIDeviceOrientation.landscapeLeft:
            previewLayer.connection?.videoOrientation = .landscapeRight

        // Home button on left
        case UIDeviceOrientation.landscapeRight:
            previewLayer.connection?.videoOrientation = .landscapeLeft

        // Home button at bottom
        case UIDeviceOrientation.portrait:
            previewLayer.connection?.videoOrientation = .portraitUpsideDown

        default:
            break
        }
    }

    func setOutputOrientation() {
        switch UIDevice.current.orientation {
        // Home button on top
        case UIDeviceOrientation.portraitUpsideDown:
            videoOutput.connection(with: .video)?.videoOrientation = .portrait

        // Home button on right
        case UIDeviceOrientation.landscapeLeft:
            videoOutput.connection(with: .video)?.videoOrientation = .landscapeRight

        // Home button on left
        case UIDeviceOrientation.landscapeRight:
            videoOutput.connection(with: .video)?.videoOrientation = .landscapeLeft

        // Home button at bottom
        case UIDeviceOrientation.portrait:
            videoOutput.connection(with: .video)?.videoOrientation = .portraitUpsideDown

        default:
            break
        }
    }

    override func willTransition(to _: UITraitCollection, with _: UIViewControllerTransitionCoordinator) {
        screenRect = UIScreen.main.bounds
        previewLayer.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)

        setOrientation()

        // Detector
        updateLayers()
    }

    func checkPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        // Permission has been granted before
        case .authorized:
            permissionGranted = true

        // Permission has not been requested yet
        case .notDetermined:
            requestPermission()

        default:
            permissionGranted = false
        }
    }

    func requestPermission() {
        sessionQueue.suspend()
        AVCaptureDevice.requestAccess(for: .video) { [unowned self] granted in
            self.permissionGranted = granted
            self.sessionQueue.resume()
        }
    }

    func setupCaptureSession() {
        // Camera input
        guard let videoDevice = AVCaptureDevice.default(.builtInDualWideCamera, for: .video, position: .back) else { return }
        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else { return }

        guard captureSession.canAddInput(videoDeviceInput) else { return }
        captureSession.addInput(videoDeviceInput)

        // Preview layer
        screenRect = UIScreen.main.bounds

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = CGRect(x: 0, y: 0, width: screenRect.size.width, height: screenRect.size.height)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill // Fill screen
        setOrientation()

        // Detector
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sampleBufferQueue"))
        captureSession.addOutput(videoOutput)

        setOutputOrientation()

        // Updates to UI must be on main queue
        DispatchQueue.main.async { [weak self] in
            self!.view.layer.addSublayer(self!.previewLayer)
        }
    }
}

struct HostedViewController: UIViewControllerRepresentable {
    @EnvironmentObject var objectDetectionViewModel: ObjectDetectionViewModel

    var targetObject: DetectionValue = .person
    var threshold: Float = 0.8
    var detectionHandler: ((String?) -> Void)?

    func makeUIViewController(context _: Context) -> ObjectDetectionViewController {
        let viewController = ObjectDetectionViewController()
        viewController.detectionHandler = detectionHandler
        viewController.threshold = threshold
        return viewController
    }

    func updateUIViewController(_ viewController: ObjectDetectionViewController, context _: Context) {
        if objectDetectionViewModel.shouldStopSession {
            viewController.stopSession()
        }
    }
}
