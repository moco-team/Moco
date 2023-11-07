//
//  BalloonView.swift
//  Moco
//
//  Created by Carissa Farry Hilmi Az Zahra on 17/10/23.
//

import SwiftUI

struct Balloon: Identifiable {
    var id = UUID()

    let color: String
    let isCorrect: Bool
}

struct BalloonView: View {
    @Environment(\.audioViewModel) private var audioViewModel
    let balloon: Balloon

    @Binding var correctTryCount: Int
    @Binding var falseTryCount: Int
    @Binding var isFinalPopUp: Bool
    @Binding var showTheAnswer: Bool
    @Binding var isCorrectBalloonTapped: Bool

    @State private var isAnimating = false
    @State private var isHidden = false

    var body: some View {
        VStack {
            if !isHidden {
                Image("Story/Content/Story1/Pages/Page9/balon-\(balloon.color)")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .opacity(isAnimating ? 0.0 : 1.0)
                    .onTapGesture {
                        if balloon.isCorrect {
                            audioViewModel.playSound(soundFileName: "success", category: .soundEffect)
                            correctTryCount += 1
                            print("Benar \(correctTryCount)")

                            withAnimation(.easeOut(duration: 0.5)) {
                                self.isAnimating = true
                            }

                            if correctTryCount < 3 {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    isCorrectBalloonTapped = true
                                }
                            } else {
                                isFinalPopUp = true
                            }
                        } else {
                            if falseTryCount > 2 {
                                showTheAnswer = true
                            } else {
                                falseTryCount += 1
                                print("Salah \(falseTryCount)")
                                audioViewModel.playSound(soundFileName: "balon_merah", category: .narration)
                                isCorrectBalloonTapped = false
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    BalloonView(
        balloon: Balloon(color: "orange", isCorrect: true),
        correctTryCount: .constant(0),
        falseTryCount: .constant(0),
        isFinalPopUp: .constant(false),
        showTheAnswer: .constant(false),
        isCorrectBalloonTapped: .constant(false)
    )
}
