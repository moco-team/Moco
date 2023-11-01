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

    @State var fadeInGameStartView = false
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
                        Text("Tap to place a environment")
                            .font(.headline)
                            .padding(32)
                    }
                }
                .frame(height: 150)
                Spacer()

                HStack {
                    Spacer()
                    if clue.meshes != nil {
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
                                width: 80,
                                height: 80,
                                backgroundColor: .clear,
                                foregroundColor: .clear
                            )
                        )
                        .padding(50)
                    }
                }
            }
            .ignoresSafeArea()

            // Loading screen
            ZStack {
                Color.white
                Text("Loading resources...")
                    .foregroundColor(Color.black)
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
                fadeInGameStartView.toggle()
            }
        }
        .opacity(fadeInGameStartView ? 1 : 0)
    }
}

#Preview {
    ARCameraView(clue: ClueData(clue: "Carilah benda yang dapat menjadi clue agar bisa menemukan Bebe!", objectName: "button", meshes: ["Mesh_button_cylinder", "Mesh_button_cube"]), onFoundObject: {})
}
