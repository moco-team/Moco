//
//  ARViewControllerContainer.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 25/10/23.
//

import RealityKit
import SwiftUI

protocol BottomSheetDelegate {
    func dismissBottomSheet()
}

struct ARViewContainer: UIViewRepresentable {
    @EnvironmentObject var viewModel: ARViewModel

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        // Configure the session
        viewModel.configureSession(forView: arView)

        // Capture taps into the ARView
        context.coordinator.arView = arView
        let tapRecognizer = UITapGestureRecognizer(target: context.coordinator,
                                                   action: #selector(Coordinator.viewTapped(_:)))
        tapRecognizer.name = "ARView Tap"
        arView.addGestureRecognizer(tapRecognizer)

        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleLongPress(_:)))
        arView.addGestureRecognizer(longPressGestureRecognizer)

        return arView
    }

    func updateUIView(_: ARView, context _: Context) {}

    class Coordinator: NSObject {
        weak var arView: ARView?
        let parent: ARViewContainer

        init(parent: ARViewContainer) {
            self.parent = parent
        }

        private var tappedEntities: [Entity]?

        @objc func viewTapped(_ gesture: UITapGestureRecognizer) {
            print("Screen tapped")

            if parent.viewModel.hasPlacedObject {
                let point = gesture.location(in: arView)

                if let tappedEntity = arView!.entity(at: point) {
                    print(tappedEntity)
                }

                return
            } else {
                print("Place an object")

                let point = gesture.location(in: gesture.view)
                guard let arView,
                      let result = arView.raycast(from: point,
                                                  allowing: .existingPlaneGeometry,
                                                  alignment: .horizontal).first,
                      let anchor = result.anchor
                else {
                    return
                }
                _ = parent.viewModel.addCup(anchor: anchor,
                                            at: result.worldTransform,
                                            in: arView)
                parent.viewModel.hasPlacedObject = true
            }
        }

        @objc func handleLongPress(_ recognizer: UILongPressGestureRecognizer) {
            let location = recognizer.location(in: arView)

            if let entity = arView!.entity(at: location) {
                print("Long pressed entity:")
                print(entity)
            
                // Check if user has found the correct object
                if entity.name == parent.viewModel.foundObjectName {
                    print("The object found is correct!")
                    print("Removed entity with name: " + entity.name)
                    parent.viewModel.hasFindObject = true
                    
                    if let anchorEntity = entity.anchor {
                        print("Removed anchor with name: " + anchorEntity.name)
                        anchorEntity.removeFromParent()
                    }
                    
                    parent.viewModel.hasPlacedObject = false
                } else {
                    print("The object found is incorrect!")
                }
            }
        }
    }

    func makeCoordinator() -> ARViewContainer.Coordinator {
        return Coordinator(parent: self)
    }
}

struct ARViewControllerContainer: UIViewControllerRepresentable {
    typealias UIViewControllerType = ARViewController

    @State private var timer: Timer?

    func makeUIViewController(context _: Context) -> ARViewController {
        let viewController = ARViewController()
        return viewController
    }

    func updateUIViewController(_: ARViewController, context _: Context) {
        // Updates the state of the specified view controller with new information from SwiftUI.
    }

    func makeCoordinator() -> ARViewControllerContainer.Coordinator {
        return Coordinator(self)
    }
}

extension ARViewControllerContainer {
    class Coordinator: NSObject, ObservableObject, BottomSheetDelegate {
        func dismissBottomSheet() {
            // TODO: Ignore this
        }

        var parent: ARViewControllerContainer

        init(_ parent: ARViewControllerContainer) {
            self.parent = parent
        }
    }
}
