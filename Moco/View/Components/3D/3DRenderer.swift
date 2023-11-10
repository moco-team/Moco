//
//  3DRenderer.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 10/11/23.
//

import SceneKit
import SceneKit.ModelIO
import SwiftUI

struct SceneKitView: UIViewRepresentable {
    func makeUIView(context _: Context) -> SCNView {
        guard let urlPath = Bundle.main.url(forResource: "tes4", withExtension: "usdz") else {
            fatalError("usdz not found")
        }
        let mdlAsset = MDLAsset(url: urlPath)
        // you can load the textures on an MDAsset so it's not white
        mdlAsset.loadTextures()

//        let asset = mdlAsset.object(at: 0) // extract first object
        // let assetNode = SCNNode(mdlObject: asset)

        let scnView = SCNView()
        scnView.scene = SCNScene(mdlAsset: mdlAsset)

        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.automaticallyAdjustsZRange = true
//        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
//        cameraNode.pivot = SCNMatrix4MakeTranslation(10, 10, 155);

        scnView.scene?.rootNode.addChildNode(cameraNode)

        scnView.pointOfView = cameraNode

        scnView.allowsCameraControl = true
        scnView.autoenablesDefaultLighting = true
        scnView.isTemporalAntialiasingEnabled = true
        scnView.defaultCameraController.maximumVerticalAngle = 10

        scnView.cameraControlConfiguration.autoSwitchToFreeCamera = false

        if let recognizers = scnView.gestureRecognizers {
            for gestureRecognizer in recognizers {
                if let gesture = gestureRecognizer as? UIPanGestureRecognizer {
                    gesture.maximumNumberOfTouches = 1
                }
            }
        }

        if let recognizers = scnView.gestureRecognizers {
            for gestureRecognizer in recognizers {
                if let gesture = gestureRecognizer as? UIRotationGestureRecognizer {
                    gesture.isEnabled = false
                }
            }
        }

        if let recognizers = scnView.gestureRecognizers {
            for gestureRecognizer in recognizers {
                if let gesture = gestureRecognizer as? UITapGestureRecognizer {
                    gesture.numberOfTapsRequired = 0
                }
            }
        }

        return scnView
    }

    func updateUIView(_: SCNView, context _: Context) {}
}

struct ThreeDRenderer: View {
    var body: some View {
        VStack {
            SceneKitView()
        }
    }
}

struct ThreeDRendererOld: View {
    private var mdlAsset: MDLAsset = {
        guard let urlPath = Bundle.main.url(forResource: "tes4", withExtension: "usdz") else {
            fatalError("usdz not found")
        }
        let mdlAsset = MDLAsset(url: urlPath)
        // you can load the textures on an MDAsset so it's not white
        mdlAsset.loadTextures()

        let asset = mdlAsset.object(at: 0) // extract first object
        // let assetNode = SCNNode(mdlObject: asset)

        return mdlAsset
    }()

    @State private var scene: SCNScene?

    private var cameraNode: SCNNode? {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        return cameraNode
    }

    var body: some View {
        VStack {
            if scene != nil {
                SceneView(
                    scene: scene,
                    pointOfView: cameraNode,
                    options: [
                        .allowsCameraControl,
                        .autoenablesDefaultLighting,
                        .temporalAntialiasingEnabled
                    ]
                )
            }
        }
        .task {
            scene = SCNScene(mdlAsset: mdlAsset)
        }
    }
}

#Preview {
    ThreeDRenderer()
}
