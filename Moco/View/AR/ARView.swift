//
//  ARView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 25/10/23.
//

import SwiftUI

// struct ARCameraView: View {
//    var body: some View {
//        VStack {
//            #if !targetEnvironment(simulator)
//                ARViewControllerContainer().edgesIgnoringSafeArea(.all)
//            #endif
//        }
//    }
// }

struct ARCameraView: View {
    @Environment(\.scenePhase) var scenePhase
    @EnvironmentObject var arViewModel: ARViewModel

    var onFindObject: () -> Void = {}

    @State var fadeInGameStartView = false

    var body: some View {
        ZStack {
            ARViewContainer().edgesIgnoringSafeArea(.all)

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
            print("Object finded")
            arViewModel.hasFindObject = false
            onFindObject()
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
    ARCameraView()
}
