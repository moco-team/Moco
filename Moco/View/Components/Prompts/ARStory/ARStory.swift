//
//  ARStory.swift
//  Moco
//
//  Created by Carissa Farry Hilmi Az Zahra on 28/10/23.
//

import SwiftUI

struct ClueData {
    let clue: String
    let objectName: String
    let meshes: [String]?
}

struct ARStory: View {
    @Environment(\.audioViewModel) private var audioViewModel
    @Environment(\.navigate) private var navigate
    @EnvironmentObject var arViewModel: ARViewModel
    
    @State private var startVisibility: Bool = false
    @State private var promptIndex = 0

    @State private var isGameStarted: Bool = false
    @State private var isTutorialFinished: Bool = false {
        didSet {
            arViewModel.isTutorialDone = self.isTutorialFinished
        }
    }

    var doneHandler: (() -> Void)?

    let clueDataArray: [ClueData] = [
        ClueData(
            clue: "Wow! kita sudah berada di pulau Arjuna. Sekarang, cari madu agar bisa menemukan Maudi!",
            objectName: "honey_jar",
            meshes: ["honey_jar"]
        ),
        ClueData(
            clue: "Bagus! Kita telah menemukan dimana Bebe dikurung! Namun, pintunya terkunci. Mari kita cari sesuatu yang dapat membuka tempat Bebe dikurung!",
            objectName: "key",
            meshes: ["key"]
        ),
        ClueData(
            clue: "Yeay!! Kita berhasil menemukan Bebe! Betapa melelahkannya perjalanan hari ini. Waktunya kita pulang, yuk mencari alat yang dapat membawa kita kembali ke Kota Mocokerto!",
            objectName: "airplane",
            meshes: ["airplane"]
        )
    ]

    var body: some View {
        ZStack {
            if isTutorialFinished {
                ARCameraView(
                    clue: clueDataArray[promptIndex],
                    lastPrompt: promptIndex == (clueDataArray.count - 1),
                    onFoundObject: {
                        isGameStarted = false // turn off the ARCameraView first, so it can generate new instance for the next prompt

                        print("Ditemukan!")
                        print("promptIndex")
                        print(promptIndex) // 2 -> selesai
                        if promptIndex < (clueDataArray.count - 1) {
                            promptIndex += 1
                        } else {
                            doneHandler?()
                        }
                    }
                )
                .id(promptIndex)
                .ignoresSafeArea()
                
                if (!arViewModel.hasPlacedObject) {
                    Image("AR/Tutorial/augmented-reality")
                        .frame(height: Screen.width * 0.3)
                }
            } else {
                ARTutorialView() {
                    print("Tutorial AR selesai")
                    isTutorialFinished = true
                    arViewModel.pause()
                    arViewModel.resetSession()
                }
                .ignoresSafeArea()
            }
            
            if promptIndex < clueDataArray.count {
                if startVisibility { // Never be true
                    ARClueView(clue: clueDataArray[promptIndex].clue, onStartGame: {
                        isGameStarted = true
                        startVisibility = false
                        audioViewModel.playSound(soundFileName: "bg-shop", numberOfLoops: -1, category: .backsound)
                    })
                    .ignoresSafeArea()
                    .frame(width: Screen.width, height: Screen.height)
                    .onDisappear {
                        withAnimation(Animation.easeIn(duration: 1.5)) {
                            startVisibility = false
                        }
                    }
                }
            }
        }
        .task {
            isTutorialFinished = arViewModel.isTutorialDone
        }
    }
}

#Preview {
    ARStory()
}
