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

    @State private var startVisibility: Bool = true
    @State private var isGameStarted: Bool = false

    var doneHandler: (() -> Void)?

    let clueData = ClueData(clue: "Wow! kita sudah berada di pulau Arjuna. Sekarang, kita perlu mencari benda yang dapat menjadi clue untuk menemukan Maudi!", objectName: "key", meshes: ["key"])

    var body: some View {
        if startVisibility {
            ARClueView(clue: clueData.clue, onStartGame: {
                isGameStarted = true
                audioViewModel.playSound(soundFileName: "s1-ep3-backsound", numberOfLoops: -1, category: .backsound)
            })
            .ignoresSafeArea()
        }
        if isGameStarted {
            ARCameraView(clue: clueData, onFoundObject: {
                isGameStarted = false
                print("Ditemukan!")
                doneHandler!()
            })
            .ignoresSafeArea()
        }
    }
}

#Preview {
    ARStory()
}
