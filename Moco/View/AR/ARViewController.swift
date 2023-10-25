//
//  ARViewController.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 25/10/23.
//

import ARKit
import RealityKit
import SwiftUI
import UIKit
import Vision

// MARK: - ARViewIndicator

struct ARViewIndicator: UIViewControllerRepresentable {
    typealias UIViewControllerType = ARViewController

    func makeUIViewController(context _: Context) -> ARViewController {
        return ARViewController()
    }

    func updateUIViewController(_:
        ARViewIndicator.UIViewControllerType, context _:
        UIViewControllerRepresentableContext<ARViewIndicator>) {}
}

extension Entity {
    func scaleAnimated(with value: SIMD3<Float>, duration: CGFloat) {
        var scaleTransform = Transform()
        scaleTransform.scale = value
        move(to: transform, relativeTo: parent)
        move(to: scaleTransform, relativeTo: parent, duration: duration)
    }
}

func getCurrentMillis() -> Int {
    Int(Date().timeIntervalSince1970 * 1000)
}

class ARViewController: UIViewController, ARSessionDelegate {
    private var arView: ARView!

    var currentBuffer: CVPixelBuffer?

    var text = ""

    #if !targetEnvironment(simulator)

        let visionQueue = DispatchQueue(label: "morsenator.visionqueue")

        private var viewportSize: CGSize! {
            return arView.frame.size
        }

        private var detectRemoteControl: Bool = true

        private var isTouching = false

        private var buttonId: UInt64?
        private var buttonName: String?

        private var buttonModel: Entity?

        var viewWidth: Int = 0
        var viewHeight: Int = 0

        private let dotDuration = 100 ... 1000
        private let dashDuration = 1000 ... 3000
        private let wordGapDuration = 1000 ... 2000
        private let letterGapDuration = 2000 ... 5000

        var box: ModelEntity!

        var recentIndexFingerPoint: CGPoint = .zero

        private var timer: Timer?
        private var timerCurrentCount = 0

        private var lastStateChange = getCurrentMillis()

        lazy var request: VNRequest = {
            var handPoseRequest = VNDetectHumanHandPoseRequest(completionHandler: handDetectionCompletionHandler)
            handPoseRequest.maximumHandCount = 1
            return handPoseRequest
        }()

        override func viewDidLoad() {
            super.viewDidLoad()

            arView = ARView(frame: view.bounds)
            view.addSubview(arView)
//        arView.delegate = self
//        arView.scene = SCNScene()
//        arView.debugOptions = [.showFeaturePoints, .showAnchorOrigins, .showAnchorGeometry]

            viewWidth = Int(arView.bounds.width)
            viewHeight = Int(arView.bounds.height)
//
//        let node = SCNNode()
//        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
//        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
//        arView.scene.rootNode.addChildNode(node)

//        self.timer = Timer.scheduledTimer(timeInterval: 0.01,
//              target: self,
//              selector: #selector(handleTimerExecution),
//              userInfo: nil,
//              repeats: true
//        )
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            let configuration = ARWorldTrackingConfiguration()
            configuration.environmentTexturing = .automatic
            configuration.planeDetection = .horizontal
            configuration.frameSemantics = [.personSegmentation]
            arView.session.run(configuration)

            let coachingOverlay = ARCoachingOverlayView()
            coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            coachingOverlay.session = arView.session
            coachingOverlay.goal = .horizontalPlane
            arView.addSubview(coachingOverlay)

            arView.session.delegate = self

//        let anchor = AnchorEntity() // Anchor (anchor that fixes the AR model)
//        anchor.position = simd_make_float3(0, -0.5, -1) // The position of the anchor is 0.5m below, 1m away the initial position of the device.
//        let box = ModelEntity(mesh: .generateBox(size: simd_make_float3(0.3, 0.1, 0.2), cornerRadius: 0.03))
//        // Make a model from a box mesh with a width of 0.3m, a height of 0.1m, a depth of 0.2m, and a radius of rounded corners of 0.03m.
//        box.transform = Transform(pitch: 0, yaw: 1, roll: 0) // Rotate the box model 1 radian on the Y axis
//        anchor.addChild(box) // Add a box to the child of the anchor in the hierarchy.
//        arView.scene.anchors.append(anchor) // Add an anchor to arView

            setupObject()
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            arView.session.pause()
            timer?.invalidate()
        }

        private func resetTracking() {
            let configuration = ARWorldTrackingConfiguration()
            configuration.planeDetection = []
            arView.session.run(configuration, options: [.removeExistingAnchors, .resetTracking])
            detectRemoteControl = true
        }

//    func renderer(_: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
//        guard anchor.name == "remoteObjectAnchor" else { return }
//        let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.01))
//        sphereNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
//        node.addChildNode(sphereNode)
//    }

        // MARK: - ARSCNViewDelegate

//    func sessionWasInterrupted(_: ARSession) {}
//
//    func sessionInterruptionEnded(_: ARSession) {}
//    func session(_: ARSession, didFailWithError _: Error) {}
//    func session(_: ARSession, cameraDidChangeTrackingState _: ARCamera) {}

        func processDetections(for request: VNRequest, error: Error?) {
            guard error == nil else {
                print("Object detection error: \(error!.localizedDescription)")
                return
            }

            guard let results = request.results else { return }

            if detectRemoteControl == false {
                return
            }

            for observation in results where observation is VNRecognizedObjectObservation {
                let ss = observation as? VNRecognizedObjectObservation
                guard let objectObservation = observation as? VNRecognizedObjectObservation,
                      let topLabelObservation = objectObservation.labels.first,
                      topLabelObservation.identifier == "dog",
                      topLabelObservation.confidence > 0.9
                else { continue }

                guard let currentFrame = arView.session.currentFrame else { continue }

                // Get the affine transform to convert between normalized image coordinates and view coordinates
                let fromCameraImageToViewTransform = currentFrame.displayTransform(for: .portrait, viewportSize: viewportSize)
                // The observation's bounding box in normalized image coordinates
                let boundingBox = objectObservation.boundingBox
                // Transform the latter into normalized view coordinates
                let viewNormalizedBoundingBox = boundingBox.applying(fromCameraImageToViewTransform)
                // The affine transform for view coordinates
                let transform = CGAffineTransform(scaleX: viewportSize.width, y: viewportSize.height)
                // Scale up to view coordinates
                let viewBoundingBox = viewNormalizedBoundingBox.applying(transform)

                let midPoint = CGPoint(x: viewBoundingBox.midX,
                                       y: viewBoundingBox.midY)

                let results = arView.hitTest(midPoint, types: [.featurePoint])
                guard let result = results.first else { continue }

//            let anchor = ARAnchor(name: "remoteObjectAnchor", transform: result.worldTransform)
//            arView.session.add(anchor: anchor)

                // Add a new anchor at the tap location.
                let arAnchor = ARAnchor(transform: result.worldTransform)
                arView.session.add(anchor: arAnchor)

                let anchor = AnchorEntity(anchor: arAnchor) // Anchor (anchor that fixes the AR model)
                anchor.position = simd_make_float3(0, -0.5, -1) // The position of the anchor is 0.5m below, 1m away the initial position of the device.
                let box = ModelEntity(mesh: .generateBox(size: simd_make_float3(0.3, 0.1, 0.2), cornerRadius: 0.03))
                // Make a model from a box mesh with a width of 0.3m, a height of 0.1m, a depth of 0.2m, and a radius of rounded corners of 0.03m.
                box.transform = Transform(pitch: 0, yaw: 1, roll: 0) // Rotate the box model 1 radian on the Y axis
                anchor.addChild(box) // Add a box to the child of the anchor in the hierarchy.
                arView.scene.anchors.append(anchor) // Add an anchor to arView

                print(midPoint)

                detectRemoteControl = false
            }
        }

        func session(_: ARSession, didUpdate frame: ARFrame) {
            let pixelBuffer = frame.capturedImage
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .up, options: [:])
                do {
                    // try handler.perform([(self?.request)!])

                } catch {
                    print(error)
                }
            }
        }

        func handDetectionCompletionHandler(request: VNRequest?, error _: Error?) {
            // Get the position of the tip of the index finger from the result of the request
            guard let observation = request?.results?.first as? VNHumanHandPoseObservation else { return }
            guard let indexFingerTip = try? observation.recognizedPoints(.all)[.indexTip],
                  indexFingerTip.confidence > 0.3 else { return }

            // Since the result of Vision is normalized to 0 ~ 1, it is converted to the coordinates of ARView.
            let normalizedIndexPoint = VNImagePointForNormalizedPoint(CGPoint(x: indexFingerTip.location.y, y: indexFingerTip.location.x), viewWidth, viewHeight)

            var buttonTouched = false

            // Perform a hit test with the acquired coordinates of the fingertips
        }

        private func setupObject() {
            do {
                let environment = try ModelEntity.load(named: "environment.usdz")

                let scalingPivot = Entity()
                scalingPivot.position.y = environment.visualBounds(relativeTo: nil).center.y
                scalingPivot.addChild(environment)

                // compensating a robot position
                environment.position.y -= scalingPivot.position.y

                let anchor = AnchorEntity()
                anchor.addChild(scalingPivot)
                arView.scene.addAnchor(anchor)

                let newTransform = Transform(scale: .one * 0.1)
                scalingPivot.move(to: newTransform,
                                  relativeTo: scalingPivot.parent,
                                  duration: 5.0)

                arView.scene.addAnchor(anchor)
            } catch {
                fatalError("Error loading model entity")
            }

//        if usdzModel != nil {
//            for animation in usdzModel!.availableAnimations {
//                print("Playing animations")
//                usdzModel!.playAnimation(animation.repeat())
//                // usdzModel?.stopAllAnimations()
//            }
//        }
        }
    #endif
}
