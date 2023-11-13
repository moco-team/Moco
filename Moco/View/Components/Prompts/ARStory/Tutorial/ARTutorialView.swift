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
    @State private var isARTutorialStart = true
    @State private var isARPlaced = false
    @State private var showPopUpARPlaced = false

    @State private var isObjectFound = false
    @State private var showPopUpObjectFound = false

    var doneHandler: (() -> Void)?

    let clue = PromptModel(
        correctAnswer: "honey_jar", // object to be found
        startTime: 3,
        promptType: PromptType.ar,
        hints: nil,
        question: "Wow! kita sudah berada di pulau Arjuna. Sekarang, cari madu agar bisa menemukan Maudi!",
        answerAssets: ["honey_jar"] // meshes
    )

    var body: some View {
        ZStack {
            // TODO: Add QR Scanner tutorial for next sprint
//            if !isQRCodeDetected {
//                CodeScannerView(
//                    codeTypes: [.qr],
//                    completion: { result in
//                        if case let .success(code) = result {
//                            // TODO: Do validate wether user detect the correct card
//                            print("hasil scan")
//                            print(result)
//
//                            showPopUpQRCodeDetected = true
//                            audioViewModel.playSound(soundFileName: "success", category: .soundEffect)
//                        } else {
//                            // TODO: Play sound coba lagi
            ////                            audioViewModel.playSound(soundFileName: "success", category: .soundEffect)
//                        }
//                    }
//                )
//
//                Image("AR/Tutorial/camera-corner")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: Screen.height * 0.6)
//
//                if isLottieVisible && !showPopUpQRCodeDetected {
//                    LottieView(fileName: "arrange_camera_to_barcode.json", loopMode: .playOnce)
//                        .frame(height: Screen.height * 0.3)
//                }
//            } else
            ARViewContainer(isShowHint: $isShowHint, meshes: clue.answerAssets ?? nil)
                .edgesIgnoringSafeArea(.all)

            // AR Tutorial illustration
            if isLottieVisible && !isARPlaced {
                ZStack {
                    Color.black.opacity(0.2)
                    Image("AR/Tutorial/plane")
                        .resizable()
                        .scaledToFit()
                        .frame(width: Screen.width * 0.3, height: Screen.height * 0.3)

                    VStack {
                        GIFView(type: .name("find-ar-plane"))
                            .frame(width: 200, height: 200)
                            .padding(.horizontal)
                            .padding(.top, -75)
                            .frame(width: 280, alignment: .center)

                        Text("Cari area datar")
                            .customFont(.didactGothic, size: 30)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
            }

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
            audioViewModel.pauseAllSounds()
            audioViewModel.playSound(
                soundFileName: "maze-bgm",
                numberOfLoops: -1,
                category: .backsound
            )

            arViewModel.setSearchedObject(objectName: clue.correctAnswer)
            arViewModel.isFinalClue = true
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
        .onDisappear {
            print("AR tutorial view menghilang")
        }
        .onChange(of: scenePhase, initial: true) { _, newPhase in
            switch newPhase {
            case .active:
                print("Load asset dr tutorial")
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
        .popUp(isActive: $showPopUpQRCodeDetected, title: "Kamu berhasil scan barcode yang benar! Sekarang mulai letakkan dunia!") {
            print("qr detected")
            isQRCodeDetected = true
            showPopUpQRCodeDetected = false
        }
        .popUp(isActive: $showPopUpARPlaced, title: "Kamu berhasil meletakkan dunia! Sekarang ayo cari madu!") {
            showPopUpARPlaced = false
        }
        .popUp(isActive: $showPopUpObjectFound, title: "Kamu telah meyelesaikan tutorial! Sekarang, mari kita mulai!") {
            doneHandler?()
            print("selesai!")
            showPopUpObjectFound = false
        }
    }
}

#Preview {
    ARTutorialView()
}
