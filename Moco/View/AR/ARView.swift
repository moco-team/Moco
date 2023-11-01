//
//  ARView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 25/10/23.
//

import SwiftUI

struct ARCameraView: View {
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var arViewModel: ARViewModel

    let clue: ClueData
    var onFoundObject: () -> Void = {}

    @State var fadeInStartAR = false
    @State var fadeInHintButton = false
    @State var isShowHint = false

    var body: some View {
        ZStack {
            ARViewContainer(isShowHint: $isShowHint, meshes: clue.meshes ?? nil).edgesIgnoringSafeArea(.all)

            // Overlay above the camera
            VStack {
                ZStack {
                    Color.black.opacity(0.3)
                    VStack {
                        Spacer()
                        Text("Tap pada layar untuk meletakkan dunia")
                            .font(.headline)
                            .padding(32)
                    }
                }
                .frame(height: 150)
                Spacer()

                HStack {
                    Spacer()
                    if clue.meshes != nil && arViewModel.hasPlacedObject != false {
                        Button {
                            print("Hint!")
                            isShowHint = true
                        } label: {
                            Image("Buttons/button-hint")
                                .resizable()
                                .scaledToFit()
                                .padding(15)
                        }
                        .buttonStyle(
                            CircleButton(
                                width: 160,
                                height: 160,
                                backgroundColor: .clear,
                                foregroundColor: .clear
                            )
                        )
                        .padding(50)
                        .onAppear {
                            withAnimation(Animation.easeIn(duration: 1.5)) {
                                fadeInHintButton.toggle()
                            }                        }
                        .opacity(fadeInHintButton ? 1 : 0)
                    }
                }
            }
            .ignoresSafeArea()

            // Loading screen
            ZStack {
                Color.white
                Text("Loading...")
                    .customFont(.cherryBomb, size: 30)
                    .foregroundColor(.blue2Txt)
                    .glowBorder(color: .white, lineWidth: 5)
            }
            .opacity(arViewModel.assetsLoaded ? 0 : 1)
            .ignoresSafeArea()
            .animation(Animation.default.speed(1),
                       value: arViewModel.assetsLoaded)
        }
        .onChange(of: scenePhase, initial: true) { _, newPhase in
            switch newPhase {
            case .active:
                print("App did become active")
                arViewModel.resume()
            case .inactive:
                print("App did become inactive")
                arViewModel.pause()
            default:
                break
            }
        }
        .onChange(of: arViewModel.hasFindObject) {
            print("Object found!")
            arViewModel.hasFindObject = false // Set back to default value, so the AR can works if user open the AR view again
            onFoundObject()
        }
        .task {
            arViewModel.setSearchedObject(objectName: clue.objectName)
        }
        .onAppear {
            withAnimation(Animation.easeIn(duration: 1.5)) {
                fadeInStartAR.toggle()
            }
        }
        .opacity(fadeInStartAR ? 1 : 0)
    }
}

#Preview {
    ARCameraView(clue: ClueData(clue: "Carilah benda yang dapat menjadi clue agar bisa menemukan Bebe!", objectName: "button", meshes: ["Mesh_button_cylinder", "Mesh_button_cube"]), onFoundObject: {})
}
