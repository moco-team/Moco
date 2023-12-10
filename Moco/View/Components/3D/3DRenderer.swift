//
//  3DRenderer.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 10/11/23.
//

import SceneKit
import SwiftUI

struct SceneKitView: UIViewRepresentable {
    func makeUIView(context _: Context) -> SCNView {
        guard let sceneUrl = Bundle.main.url(forResource: "Floating_Lighthouse", withExtension: "usdz") else { fatalError() }

        let scnView = SCNView()
        scnView.scene = try! SCNScene(url: sceneUrl, options: [.checkConsistency: true])
        scnView.backgroundColor = .clear

        scnView.allowsCameraControl = true
        scnView.autoenablesDefaultLighting = true
        scnView.isTemporalAntialiasingEnabled = true
        scnView.antialiasingMode = .multisampling4X

        let camera = scnView.defaultCameraController
        let cameraConfig = scnView.cameraControlConfiguration

        camera.maximumVerticalAngle = 50
        camera.minimumVerticalAngle = 10

        camera.interactionMode = .orbitTurntable

        cameraConfig.rotationSensitivity = 0.3
        cameraConfig.panSensitivity = 0.3

        camera.pointOfView?.worldPosition = SCNVector3(x: 0, y: 0, z: 30)

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
                        Text("To be continued...")
                            .customFont(.cherryBomb, size: UIDevice.isIPad ? 30 : 20)
                            .foregroundColor(.blue2Txt)
                            .glowBorder(color: .white, lineWidth: 5)
                        Button("Keluar") {
                            navigate.popToRoot()
                            action()
                        }
                        .buttonStyle(MainButton(width: UIDevice.isIPad ? 180 : 100, type: .danger))
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
//            scene = SCNScene(mdlAsset: mdlAsset)
        }
    }
}

#Preview {
    ThreeDRenderer {}
}
