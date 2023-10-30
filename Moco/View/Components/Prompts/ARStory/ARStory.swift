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
}

struct ARStory: View {
    @Environment(\.audioViewModel) private var audioViewModel

    @State private var startVisibility: Bool = true
    @State private var isGameStarted: Bool = false

    var doneHandler: (() -> Void)?
    
    let clueData = ClueData(clue: "Carilah benda yang dapat menjadi clue agar bisa menemukan Bebe!", objectName: "environment")

    var body: some View {
        if startVisibility {
            ARClueView(clue: clueData.clue, onStartGame: {
                isGameStarted = true
                audioViewModel.playSound(soundFileName: "bg-shop", numberOfLoops: -1)
            })
            .ignoresSafeArea()
        }
        if isGameStarted {
            ARCameraView(objectToBeFound: clueData.objectName, onFoundObject: {
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
