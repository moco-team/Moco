//
//  ARTutorialView.swift
//  Moco
//
//  Created by Carissa Farry Hilmi Az Zahra on 09/11/23.
//

import CodeScanner
import SwiftUI

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size _: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}

struct ARTutorialView: View {
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.audioViewModel) private var audioViewModel
    @EnvironmentObject var arViewModel: ARViewModel

    @State private var shakeAnimation: CGFloat = 0
    @State private var isLottieVisible = true
    @State private var isQRCodeDetected = false
    @State private var showPopUpQRCodeDetected = false

    @State var isShowHint = true
    @State private var isARTutorialStart = false
    @State private var isARPlaced = false
    @State private var showPopUpARPlaced = false

    @State private var isObjectFound = false
    @State private var showPopUpObjectFound = false

    var doneHandler: (() -> Void)?

    let clue = ClueData(
        clue: "Wow! kita sudah berada di pulau Arjuna. Sekarang, kita perlu mencari benda yang dapat menjadi clue untuk menemukan Maudi!",
        objectName: "honey_jar",
        meshes: ["honey_jar"]
    )

    var body: some View {
        ZStack {
            if !isQRCodeDetected {
                CodeScannerView(
                    codeTypes: [.qr],
                    completion: { result in
                        if case let .success(code) = result {
                            // TODO: Do validate wether user detect the correct card
                            print("hasil scan")
                            print(result)

                            showPopUpQRCodeDetected = true
                            audioViewModel.playSound(soundFileName: "success", category: .soundEffect)
                        } else {
                            // TODO: Play sound coba lagi
//                            audioViewModel.playSound(soundFileName: "success", category: .soundEffect)
                        }
                    }
                )

                Image("AR/Tutorial/camera-corner")
                    .resizable()
                    .scaledToFit()
                    .frame(height: Screen.height * 0.6)

                if isLottieVisible {
                    LottieView(fileName: "arrange_camera_to_barcode.json", loopMode: .playOnce)
                        .frame(height: Screen.height * 0.3)
                }
            } else if !isARTutorialStart {
                ARViewContainer(isShowHint: $isShowHint, meshes: clue.meshes ?? nil)
                    .edgesIgnoringSafeArea(.all)

                // Completion
                if isLottieVisible && !isARPlaced {
                    VStack {
                        Image("AR/Tutorial/augmented-reality")
                            .frame(height: Screen.height * 0.3)
                    }
                }
            }

//            ZStack{
//                Image("Components/modal-base")
//                    .resizable().scaledToFit()
//                    .frame(height: 100)

//                Text("Scan kode kartu")
//                    .customFont(.didactGothic, size: 30)
//                    .foregroundColor(.blue2Txt)
//                    .glowBorder(color: .white, lineWidth: 6)
//                    .padding(.horizontal, 120)
//                    .multilineTextAlignment(.center)
//            }
//            .modifier(Shake(animatableData: shakeAnimation))
        }
        .task {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    shakeAnimation = 1 // Set shakeAnimation to trigger the effect
                }
            }

            // Set up a timer to trigger the shake animation every 4 seconds
            Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { _ in
                withAnimation {
                    isLottieVisible = false
//                   shakeAnimation = 1 // Set shakeAnimation to trigger the effect
                }

                // Reset shakeAnimation after a short delay to stop the shake effect
//               DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                   shakeAnimation = 0
//               }

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        isLottieVisible = true
                    }
                }
            }
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
        .onChange(of: arViewModel.hasPlacedObject) {
            if arViewModel.hasPlacedObject {
                isARPlaced = true
                print("Env has been placed")
                showPopUpARPlaced = true
            }
        }
        .onChange(of: arViewModel.hasFindObject) {
            print("Object found!")
            arViewModel.hasFindObject = false // Set back to default value, so the AR can works if user open the AR view again
            showPopUpObjectFound = true
        }
        .task {
            audioViewModel.playSound(
                soundFileName: "maze-bgm",
                numberOfLoops: -1,
                category: .backsound
            )
            arViewModel.setSearchedObject(objectName: clue.objectName)
            arViewModel.isFinalClue = true
        }
        .popUp(isActive: $showPopUpQRCodeDetected, title: "Kamu berhasil scan barcode yang benar! Sekarang mulai letakkan dunia!") {
            print("qr detected")
            isQRCodeDetected = true
            showPopUpQRCodeDetected = false
        }
        .popUp(isActive: $showPopUpARPlaced, title: "Kamu berhasil meletakan dunia! Sekarang ayo cari madu!") {
            showPopUpARPlaced = false
        }
        .popUp(isActive: $showPopUpObjectFound, title: "Kamu telah meyelesaikan tutorial! Sekarang, mari kita mulai!") {
            doneHandler?()
            print("selesai!")
            isARTutorialStart = true
            showPopUpObjectFound = false
        }
    }
}

#Preview {
    ARTutorialView()
}
