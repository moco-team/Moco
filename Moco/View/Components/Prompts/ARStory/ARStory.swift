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

    @State private var startVisibility: Bool = true
    @State private var promptIndex = 0
    @State private var isGameStarted: Bool = false

    var doneHandler: (() -> Void)?

    let clueDataArray: [ClueData] = [
        ClueData(clue: "Wow! kita sudah berada di pulau Arjuna. Sekarang, kita perlu mencari benda yang dapat menjadi clue untuk menemukan Maudi!", objectName: "honey_jar", meshes: ["honey_jar"]),
        ClueData(clue: "Bagus! Kita telah menemukan dimana Bebe dikurung! Namun, pintunya terkunci. Mari kita cari sesuatu yang dapat membuka tempat Bebe dikurung!", objectName: "key", meshes: ["key"]),
        ClueData(clue: "Yeay!! Kita berhasil menemukan Bebe! Betapa melelahkannya perjalanan hari ini. Waktunya kita pulang, yuk mencari alat yang dapat membawa kita kembali ke Kota Mocokerto!", objectName: "airplane", meshes: ["airplane"]),
    ]

    var body: some View {
        if promptIndex < (clueDataArray.count - 1) {
            if startVisibility {
                ARClueView(clue: clueDataArray[promptIndex].clue, onStartGame: {
                    isGameStarted = true
                    audioViewModel.playSound(soundFileName: "bg-shop", numberOfLoops: -1, category: .backsound)
                })
                .ignoresSafeArea()
            }
        }
        if isGameStarted {
            ARCameraView(
                clue: clueDataArray[promptIndex],
                lastPrompt: promptIndex == (clueDataArray.count - 1),
                onFoundObject: {
                    isGameStarted = false // turn of the arcameraview first, so it can generate new instance for the next prompt

                    print("Ditemukan!")
                    promptIndex += 1
                    print("promptIndex")
                    print(promptIndex) // 2
                    if promptIndex < clueDataArray.count {
                        print("asu")
                        isGameStarted = true
                    }
                    if promptIndex >= clueDataArray.count {
                        doneHandler!()
                    }
            })
            .ignoresSafeArea()
            
        }
    }
}

#Preview {
    ARStory()
}
