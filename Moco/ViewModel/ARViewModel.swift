//
//  ARViewModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 25/10/23.
//

import ARKit
import Combine
import Foundation
import RealityKit

final class ARViewModel: NSObject, ObservableObject {
    static var shared = ARViewModel()
    /// Allow loading to take a minimum amount of time, to ease state transitions
    private static let loadBuffer: TimeInterval = 2

    private let resourceLoader = ResourceLoader()
    private var loadCancellable: AnyCancellable?
    private var anchors = [UUID: AnchorEntity]()

    @Published var assetsLoaded = false
    @Published var hasPlacedObject: Bool = false
    @Published var hasFindObject: Bool = false
    @Published var foundObjectName: String?
    @Published var isFinalClue: Bool = false
    @Published var toBeFoundEntityNames: [String] = ["honey_jar", "key", "airplane"]

    var arView: ARView?

    var isTutorialDone: Bool {
        get {
            GlobalStorage.arTutorialFinished
        }
        set {
            GlobalStorage.arTutorialFinished = newValue
        }
    }

    func resume() {
        if !assetsLoaded && loadCancellable == nil {
            loadAssets()
            print("Load Asset ...")
        }
    }

    func pause() {
        loadCancellable?.cancel()
        loadCancellable = nil
    }

    func configureSession(forView arView: ARView) {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        arView.session.run(config)
        arView.session.delegate = self
        self.arView = arView
    }

    func resetSession() {
        // Stop the current AR session
        arView?.session.pause()

        // Remove anchors
        arView?.scene.anchors.removeAll()
    }

    func resetStates() {
        assetsLoaded = false
        hasPlacedObject = false
        hasFindObject = false
        isFinalClue = false
    }

    func setSearchedObject(objectName: String) {
        foundObjectName = objectName
    }

    func addCup(anchor: ARAnchor,
                at worldTransform: simd_float4x4,
                in view: ARView) -> Entity? {
        // Create a new cup to place at the tap location
        let environment: Entity
        do {
            environment = try resourceLoader.createEnvironment()
        } catch {
            print("Failed to create environment: \(error)")
            return nil
        }

        defer {
            // Get translation from transform
            let column = worldTransform.columns.3
            let translation = SIMD3<Float>(column.x, column.y, column.z)

            // Move the cup to the tap location
            environment.setPosition(translation, relativeTo: nil)
        }

        #if !targetEnvironment(simulator)

            // Creating parent ModelEntity
            let parentEntity = ModelEntity()
            parentEntity.name = environment.name // Set entity name based on added object's name
            parentEntity.addChild(environment)

            // If there is not already an anchor here, create one
            guard let anchorEntity = anchors[anchor.identifier] else {
                // Anchoring the entity and adding it to the scene
                let anchorEntity = AnchorEntity(anchor: anchor)
                anchorEntity.addChild(environment)
                view.scene.addAnchor(anchorEntity)
                environment.generateCollisionShapes(recursive: true)

                // Add animation

                // Generate collision
                let entityBounds = environment.visualBounds(relativeTo: parentEntity)
                parentEntity.collision = CollisionComponent(
                    shapes: [ShapeResource.generateBox(size: entityBounds.extents).offsetBy(translation: entityBounds.center)]
                )

                // Installing gestures for the parentEntity
                view.installGestures(for: parentEntity)

                anchors[anchor.identifier] = anchorEntity

                toBeFoundEntityNames.forEach { entityName in
                    if entityName != foundObjectName {
                        environment.findEntity(named: entityName)?.removeFromParent()
                    }
                }

                return environment
            }

            // Add the cup to the existing anchor
            anchorEntity.addChild(environment)
        #endif
        return environment
    }

    // MARK: - Private methods

    private func loadAssets() {
        let beforeTime = Date().timeIntervalSince1970
        loadCancellable = resourceLoader.loadResources { [weak self] result in
            guard let self else {
                return
            }
            switch result {
            case let .failure(error):
                print("Failed to load assets \(error)")
            case .success:
                let delta = Date().timeIntervalSince1970 - beforeTime
                var buffer = Self.loadBuffer - delta
                if buffer < 0 {
                    buffer = 0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + buffer) {
                    self.assetsLoaded = true
                }
            }
        }
    }
}

// MARK: - ARSessionDelegate

extension ARViewModel: ARSessionDelegate {
    func session(_: ARSession, didRemove anchors: [ARAnchor]) {
        anchors.forEach { anchor in
            guard let anchorEntity = self.anchors[anchor.identifier] else {
                return
            }
            // Lost an anchor, remove the AnchorEntity from the Scene
            anchorEntity.scene?.removeAnchor(anchorEntity)
            self.anchors.removeValue(forKey: anchor.identifier)
        }
    }

    func session(_: ARSession, didUpdate anchors: [ARAnchor]) {
        if !anchors.isEmpty {
//            print("ANCHORS NOT EMPTY")
//            print(anchors.last!)

            // Automatically set the point to middle of the screen
            let point = CGPoint(x: Screen.width / 2, y: Screen.height / 2)

            guard arView != nil,
                  let result = arView!.raycast(from: point,
                                               allowing: .existingPlaneGeometry,
                                               alignment: .horizontal).first,
                  let anchor = result.anchor
            else {
                return
            }

            if !hasPlacedObject && !hasFindObject {
//                _ = self.addCup(anchor: point, at:anchors.last!.transform, in: self.arView!)
                _ = addCup(anchor: anchor, at: result.worldTransform, in: arView!)
                print("add cup, change the value of hasPlacedObject")
                hasPlacedObject = true
            }

        } else {
            print("Anchors is empty!")
        }
    }
}
