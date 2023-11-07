//
//  ARViewContainer.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 25/10/23.
//

import RealityKit
import RKFade
import SwiftUI

protocol BottomSheetDelegate {
    func dismissBottomSheet()
}

struct ARViewContainer: UIViewRepresentable {
    @EnvironmentObject var viewModel: ARViewModel

    @Binding var isShowHint: Bool
    let meshes: [String]?

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        arView.environment.lighting.intensityExponent = 1.5

        // Configure the session
        viewModel.configureSession(forView: arView)

        // Capture taps into the ARView
        context.coordinator.arView = arView
        let tapRecognizer = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.viewTapped(_:)))
        tapRecognizer.name = "ARView Tap"
        arView.addGestureRecognizer(tapRecognizer)

        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleLongPress(_:)))
        arView.addGestureRecognizer(longPressGestureRecognizer)

        return arView
    }

    func updateUIView(_: ARView, context: Context) {
        if isShowHint {
            if meshes != nil {
                print("Hint showed!")
                context.coordinator.showHint()
            } else {
                print("There are no meshes to be clued!")
            }
        } else {
            print("Hint not showed!")
        }
    }

    func makeCoordinator() -> ARViewContainer.Coordinator {
        return Coordinator(parent: self, isShowHint: $isShowHint, meshes: meshes)
    }

    class Coordinator: NSObject {
        weak var arView: ARView?

        let parent: ARViewContainer
        @Binding var isShowHint: Bool
        let meshes: [String]?

        init(parent: ARViewContainer, isShowHint: Binding<Bool>, meshes: [String]?) {
            self.parent = parent
            _isShowHint = isShowHint
            self.meshes = meshes ?? nil
        }

        private var tappedEntities: [Entity]?
        private var longPressedEntitites: [Entity]?

        @objc func viewTapped(_ gesture: UITapGestureRecognizer) {
            print("Screen tapped")

            if parent.viewModel.hasPlacedObject {
                let point = gesture.location(in: arView)

                tappedEntities = arView!.entities(at: point)
                let entities = tappedEntities?.filter { $0.name.contains(parent.viewModel.foundObjectName!) }
                checkFoundObject(entities: entities!)

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

            longPressedEntitites = arView!.entities(at: location)
            let entities = longPressedEntitites?.filter { $0.name.contains(parent.viewModel.foundObjectName!) }
            checkFoundObject(entities: entities!)
        }

        func checkFoundObject(entities: [Entity]) {
            for entity in entities {
                if entity.name.contains(parent.viewModel.foundObjectName!) {
                    print("The object found is correct!")
                    print("Removed entity with name: " + entity.name)

                    if let anchorEntity = entity.anchor {
                        entity.fadeOut(duration: 2, recursive: true) { [self] in
                            print("Removed anchor with name: " + anchorEntity.name)
                            anchorEntity.removeFromParent()

                            print("Removed entity with name: " + entity.name)
                            self.parent.viewModel.hasFindObject = true

                            print("isfinalclue")
                            print(self.parent.viewModel.isFinalClue)
                        }

                        // TODO: Set to false only for the last clue
//                        if self.parent.viewModel.isFinalClue {
                        parent.viewModel.hasPlacedObject = false
                        print("set to false")
                        print(parent.viewModel.hasPlacedObject)
//                        }
                    }
                } else {
                    print("The object found is incorrect!")
                }
            }
        }

        func showHint() {
            var meshesToBeFound: [Entity] = []

            if meshes != nil {
                if let environmentEntity = arView?.scene.findEntity(named: "environment") {
                    if let firstChild = environmentEntity.children.first {
                        for meshName in meshes! {
                            if let meshEntity = firstChild.findEntity(named: meshName) {
                                meshesToBeFound.append(meshEntity)
                                updateEntityColor(entity: meshEntity)
                            }
                        }
                    }
                }
            }

            print("meshes to be found")
            print(meshesToBeFound)
        }

        func updateEntityColor(entity: Entity) {
            guard
                var modelComponent = entity.components[ModelComponent.self] as? ModelComponent,
                let existingMaterial = modelComponent.materials.first
            else { return }

            // Change the color
            var material = SimpleMaterial()
            material.color = .init(tint: .yellow)

            modelComponent.materials = [material]
            entity.components.set(modelComponent)

            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
                modelComponent.materials = [existingMaterial]
                entity.components.set(modelComponent)
                self.isShowHint = false
            }
        }
    }
}
