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
        guard let urlPath = Bundle.main.url(forResource: "Floating_Lighthouse", withExtension: "usdz") else {
            fatalError("usdz not found")
        }
        let mdlAsset = MDLAsset(url: urlPath)
        // you can load the textures on an MDAsset so it's not white
        mdlAsset.loadTextures()

//        let asset = mdlAsset.object(at: 0) // extract first object
        // let assetNode = SCNNode(mdlObject: asset)

        let scnView = SCNView()
        scnView.backgroundColor = UIColor.clear
        scnView.scene = SCNScene(mdlAsset: mdlAsset)

        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 3.5, z: 15)

        scnView.scene?.rootNode.addChildNode(cameraNode)

        scnView.debugOptions = .showWorldOrigin

        scnView.allowsCameraControl = true
        scnView.autoenablesDefaultLighting = true
        scnView.isTemporalAntialiasingEnabled = true

//        scnView.cameraControlConfiguration.autoSwitchToFreeCamera = false

        let camera = scnView.defaultCameraController
        let cameraConfig = scnView.cameraControlConfiguration
        camera.pointOfView?.look(at: SCNVector3(x: 0, y: 0, z: 0))

        camera.maximumVerticalAngle = 50
        camera.minimumVerticalAngle = 20

        camera.interactionMode = .orbitTurntable

        cameraConfig.rotationSensitivity = 0.3
        cameraConfig.panSensitivity = 0.3

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
    @Environment(\.audioViewModel) private var audioViewModel
    @Environment(\.navigate) private var navigate

    @State var fadeInView: Bool = false
    @State private var showQuitButton: Bool = false
    @State private var shakeAnimation: CGFloat = 0

    let action: () -> Void?

    var body: some View {
        ZStack {
            SceneKitView()
                .task {
                    audioViewModel.playSound(
                        soundFileName: "014 - Selamat! Kamu berhasil menyelesaikan petualangan ini",
                        type: "m4a",
                        category: .narration
                    )
                    // TODO: Dubbing for the to be continued story
                    // ex: moco pun masuk ke dunia lain
                }
                .onAppear {
                    withAnimation(.easeIn(duration: 1)) {
                        fadeInView.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            showQuitButton = true
                        }
                    }
                }
                .opacity(fadeInView ? 1 : 0)

            if showQuitButton {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button("Keluar") {
                            navigate.popToRoot()
                            action()
                        }
                        .buttonStyle(MainButton(width: 180, type: .danger))
                        .padding(.bottom, 20)
                        .modifier(ShakeEffect(animatableData: shakeAnimation))
                    }
                }
            }
        }
        .task {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    shakeAnimation = 1 // Set shakeAnimation to trigger the effect
                }
            }
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
    ThreeDRenderer {}
}
