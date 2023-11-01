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

    let clueData = ClueData(clue: "Carilah benda yang dapat menjadi clue agar bisa menemukan Bebe!", objectName: "honey_jar", meshes: ["honey_jar"])

    var body: some View {
        if startVisibility {
            ARClueView(clue: clueData.clue, onStartGame: {
                isGameStarted = true
                audioViewModel.playSound(soundFileName: "bg-shop", numberOfLoops: -1, category: .backsound)
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
