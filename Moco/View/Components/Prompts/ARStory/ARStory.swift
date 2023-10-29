//
//  ARStory.swift
//  Moco
//
//  Created by Carissa Farry Hilmi Az Zahra on 28/10/23.
//

import SwiftUI

struct ARStory: View {
    @Environment(\.audioViewModel) private var audioViewModel
    
    @State private var startVisibility: Bool = true
    @State private var isGameStarted: Bool = false
    
    var doneHandler: (() -> Void)?
    
    private let clues: [String] = [
        "Carilah benda yang dapat menjadi clue agar bisa menemukan Bebe!"
    ]
    
    var body: some View {
        if(startVisibility){
            ARClueView(clue: clues[0], onStartGame: {
                isGameStarted = true
                audioViewModel.playSound(soundFileName: "bg-shop", numberOfLoops: -1)
            })
            .ignoresSafeArea()
        }
        if isGameStarted {
            ARCameraView(onFindObject: {
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
