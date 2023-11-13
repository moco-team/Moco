//
//  ARStory.swift
//  Moco
//
//  Created by Carissa Farry Hilmi Az Zahra on 28/10/23.
//

import SwiftUI

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
    @State private var isStoryDone: Bool = false
    
    var prompt: PromptModel = PromptModel(
        correctAnswer: "honey_jar", // object to be found
        startTime: 0,
        promptType: PromptType.ar,
        hints: nil,
        question: "Wow! kita sudah berada di pulau Arjuna. Sekarang, cari madu agar bisa menemukan Maudi!",
        answerAssets: ["honey_jar"] // meshes
    )
    var lastPrompt = false

    var doneHandler: (() -> Void)?

//    let promptArray: [PromptModel] = [
//        PromptModel(
//            correctAnswer: "honey_jar", // object to be found
//            startTime: 3,
//            promptType: PromptType.ar,
//            hints: nil,
//            question: "Wow! kita sudah berada di pulau Arjuna. Sekarang, cari madu agar bisa menemukan Maudi!",
//            answerAssets: ["honey_jar"] // meshes
//        ),
//        PromptModel(
//            correctAnswer: "key", 
//            startTime: 3,
//            promptType: PromptType.ar,
//            hints: nil,
//            question: "Bagus! Kita telah menemukan dimana Bebe dikurung! Namun, pintunya terkunci. Mari kita cari sesuatu yang dapat membuka tempat Bebe dikurung!",
//            answerAssets: ["key"]
//        ),
//        PromptModel(
//            correctAnswer: "airplane", 
//            startTime: 3,
//            promptType: PromptType.ar,
//            hints: nil,
//            question: "Yeay!! Kita berhasil menemukan Bebe! Betapa melelahkannya perjalanan hari ini. Waktunya kita pulang, yuk mencari alat yang dapat membawa kita kembali ke Kota Mocokerto!",
//            answerAssets: ["airplane"]
//        )
//    ]

    var body: some View {
        ZStack {
            if isTutorialFinished {
                if !isStoryDone {
                    ARCameraView(
                        clue: prompt,
                        lastPrompt: lastPrompt,
    //                    clue: promptArray[promptIndex],
    //                    lastPrompt: promptIndex == (promptArray.count - 1),
                        onFoundObject: {
                            isGameStarted = false // turn off the ARCameraView first, so it can generate new instance for the next prompt

                            print("Ditemukan!")
                            print("promptIndex")
                            print(promptIndex) // 2 -> selesai
    //                        if promptIndex < (promptArray.count - 1) {
    //                            promptIndex += 1
    //                        } else {
    //                            doneHandler?()
    //                        }
                            isStoryDone = true
//                            doneHandler?()
                        }
                    )
                    .id(promptIndex)
                    
                    if (!arViewModel.hasPlacedObject) {
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
                } else {
                    ThreeDRenderer() {
                        doneHandler?()
                    }
                }
            } else {
                ARTutorialView() {
                    print("Tutorial AR selesai")
                    isTutorialFinished = true
                    arViewModel.pause()
                    arViewModel.resetSession()
                }
            }
            
            // Not will be used
//            if promptIndex < promptArray.count {
//                if startVisibility { // Never be true
//                    ARClueView(clue: promptArray[promptIndex].question!, onStartGame: {
//                        isGameStarted = true
//                        startVisibility = false
//                        audioViewModel.playSound(soundFileName: "bg-shop", numberOfLoops: -1, category: .backsound)
//                    })
//                    .ignoresSafeArea()
//                    .frame(width: Screen.width, height: Screen.height)
//                    .onDisappear {
//                        withAnimation(Animation.easeIn(duration: 1.5)) {
//                            startVisibility = false
//                        }
//                    }
//                }
//            }
        }
        .ignoresSafeArea()
        .frame(width: Screen.width, height: Screen.height)
        .task {
            isTutorialFinished = arViewModel.isTutorialDone
        }
    }
}

#Preview {
    ARStory(
        prompt: PromptModel(
            correctAnswer: "honey_jar", // object to be found
            startTime: 3,
            promptType: PromptType.ar,
            hints: nil,
            question: "Wow! kita sudah berada di pulau Arjuna. Sekarang, cari madu agar bisa menemukan Maudi!",
            answerAssets: ["honey_jar"] // meshes
        ), 
        lastPrompt: true
    )
}
