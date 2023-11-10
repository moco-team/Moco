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
    let lastPrompt: Bool
    var onFoundObject: () -> Void = {}
    var onEnd: () -> Void = {}

    @State var fadeInStartAR = false
    @State var fadeInHintButton = false
    @State var isShowHint = true
    @State var isPopUpActive = false
    @State var isFinalPopUpActive = false
    @State var isEndTheStoryPopupActive = false
    @State var isLastNarrativePopupActive = false

    var body: some View {
        ZStack {
            ARViewContainer(isShowHint: $isShowHint, meshes: clue.meshes ?? nil).edgesIgnoringSafeArea(.all)

            // Overlay above the camera
            VStack {
                ZStack {
                    Image("Components/modal-base").resizable().scaledToFill()
                        .padding(80)
                        .position(x: Screen.width / 2, y: 10.0)

                    Text(clue.clue)
                        .customFont(.didactGothic, size: 30)
                        .foregroundColor(.blue2Txt)
                        .glowBorder(color: .white, lineWidth: 5)
                        .padding(.horizontal, 120)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(height: 150)
                Spacer()

                HStack {
                    Spacer()
                    if clue.meshes != nil && arViewModel.hasPlacedObject {
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
                            }
                        }
                        .onDisappear {
                            withAnimation(Animation.easeIn(duration: 1.5)) {
                                fadeInHintButton.toggle()
                            }
                        }
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
        .popUp(isActive: $isPopUpActive, title: "Selamat! Kamu berhasil menemukan benda nya! Mari kita cari benda selanjutnya!") {
            print("next")
            print(lastPrompt)
            onFoundObject()
            isPopUpActive = false
        }
        .popUp(isActive: $isFinalPopUpActive, title: "Selamat! Kamu berhasil menemukan semua benda nya!") {
            isFinalPopUpActive = false
            isLastNarrativePopupActive = true
        }
        .popUp(isActive: $isLastNarrativePopupActive, title: "Akhirnya, Moco dan teman-teman berhasil pulang ke Kota Mocokerto setelah petualangan yang panjang. Terima kasih untuk hari ini!") {
            isLastNarrativePopupActive = false
            isEndTheStoryPopupActive = true
            onEnd()
        }
        .popUp(
            isActive: $isEndTheStoryPopupActive,
            title: "Akhiri petualangan dan keluar dari Pulau Arjuna?",
            confirmText: "Akhiri"
        ) {
            onFoundObject()
            isEndTheStoryPopupActive = false
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

            if lastPrompt {
                isFinalPopUpActive = true
            } else {
                isPopUpActive = true
            }
        }
        .task {
            arViewModel.setSearchedObject(objectName: clue.objectName)
            arViewModel.isFinalClue = lastPrompt
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
    ARCameraView(
        clue: ClueData(
            clue: "Carilah benda yang dapat menjadi clue agar bisa menemukan Bebe!",
            objectName: "button",
            meshes: ["Mesh_button_cylinder", "Mesh_button_cube"]
        ),
        lastPrompt: false,
        onFoundObject: {}
    )
}
