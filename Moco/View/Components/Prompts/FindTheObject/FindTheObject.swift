//
//  SwiftUIView.swift
//  Moco
//
//  Created by Carissa Farry Hilmi Az Zahra on 17/10/23.
//

import SwiftUI

struct FindTheObjectView: View {
    @Environment(\.navigate) private var navigate
    
    @Binding var isPromptDone: Bool
    
    let content: String
    let hints: [String]
    let correctAnswer: String
    @State var balloons: [Balloon]
    
    let maxTry = 3
    
    @State private var correctTryCount = 0
    @State private var falseTryCount = 0
    @State private var isTried = false
    @State private var showTheAnswer = false
    @State private var isCorrectBalloonTapped = false
    @State private var isAnimating = false
    @State private var isFinalPopUp = false
    
    @State private var showTheBalloons = true
    
    var body: some View {
        VStack {
            if showTheBalloons {
                HStack(spacing: 100) {
                    ForEach(balloons.indices, id: \.self) { index in
                        BalloonView(
                            balloon: balloons[index],
                            correctTryCount: $correctTryCount,
                            falseTryCount: $falseTryCount,
                            isFinalPopUp: $isFinalPopUp,
                            showTheAnswer: $showTheAnswer,
                            isCorrectBalloonTapped: $isCorrectBalloonTapped
                        )
                    }
                }
                .padding(.horizontal, Screen.width * 0.1)
                .opacity(showTheBalloons ? 1.0 : 0.0)
                .animation(.easeOut)
            }
        }
        .padding(.vertical, 60)
        .popUp(isActive: $isCorrectBalloonTapped, title: "Selamat kamu sudah menemukan balon yang Moco cari! \n Ayo cari balon selanjutnya!") {
            if correctTryCount < maxTry {
                isTried = false
                isCorrectBalloonTapped = false
                balloons.shuffle()
            } else {
                isPromptDone = true
                print(isPromptDone)
                print("Selesai!")
            }
        }
        .popUp(isActive: $showTheAnswer, title: correctAnswer) {
            isPromptDone = true
            print("Selesai!")
        }
        .popUp(isActive: $isFinalPopUp, title: "Selamat kamu berhasil mencari semua balon Moco!") {
            isPromptDone = true
        }
    }
}

#Preview {
    FindTheObjectView(
        isPromptDone: .constant(false),
        content: "Once upon a time...",
        hints: ["Coba lagi!", "Ayo coba lagi!"],
        correctAnswer: "Jawaban yang benar adalah balon berwarna Merah",
        balloons: [
            Balloon(color: "orange", isCorrect: false),
            Balloon(color: "ungu", isCorrect: false),
            Balloon(color: "merah", isCorrect: true),
            Balloon(color: "hijau", isCorrect: false),
            Balloon(color: "biru", isCorrect: false)
        ]
    )
}
