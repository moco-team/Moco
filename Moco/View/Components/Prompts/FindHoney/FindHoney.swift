//
//  FindHoney.swift
//  Moco
//
//  Created by Carissa Farry Hilmi Az Zahra on 17/10/23.
//

import SwiftUI

struct FindHoney: View {
    @Environment(\.audioViewModel) private var audioViewModel
    
    @Binding var isPromptDone: Bool
    
    @State private var imageOffsets: CGPoint = CGPoint.zero
    @State private var showPopUp = false
    @State private var isFloating = true
    
    var body: some View {
        VStack {
            Image("Story/Content/Story1/Pages/Page4/honey")
            .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                .position(
                    x: imageOffsets.x,
                    y: imageOffsets.y
                )
                .animation(Animation.easeInOut(duration: 5.0).repeatForever(autoreverses: true), value: isFloating)
                .onTapGesture {
                    audioViewModel.playSound(soundFileName: "success")
                    showPopUp = true
                }
        }
        .onAppear {
            randomImageOffet()
        }
        .popUp(isActive: $showPopUp, title: "Selamat kamu berhasil menemukan Madu!") {
            isPromptDone = true
        }
    }
    
    func randomImageOffet() {
        imageOffsets = CGPoint(x: .random(in: 0..<Screen.width), y: .random(in: 0..<Screen.height))
    }
}

#Preview {
    FindHoney(isPromptDone: .constant(false))
}
