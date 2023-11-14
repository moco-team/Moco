//
//  CardPrompt.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 13/11/23.
//

import SwiftUI

enum CardState {
    case active
    case inactive
    case revealed
}

struct CardPrompt: View {
    @Environment(\.promptViewModel) private var promptViewModel
    
    @State private var currentCard = 0
    @State private var showQuestionPopup = false
    @State private var questionPopup = ""
    @State private var showScanner = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 20) {
                    if let prompts = promptViewModel.prompts {
                        ForEach(Array(prompts.enumerated()), id: \.offset) { index, prompt in
                            CardView(
                                state: index < currentCard ?
                                    .revealed :
                                    index == currentCard ?
                                    .active :
                                        .inactive,
                                revealedImage: prompt.imageCard!,
                                text: prompt.correctAnswer,
                                suffix: prompt.correctAnswer == "Teka dan Teki" ? "" : ","
                            ) {
                                questionPopup = prompt.question!
                                showQuestionPopup = true
                            }
                        }
                    }
                }
                Text("suka bermain bersama")
                    .customFont(.didactGothic, size: 40)
            }
            if showScanner {
                CardScan {
                    currentCard += 1
                    showScanner = false
                }
            }
        }
        .popUp(
            isActive: $showQuestionPopup,
            title: questionPopup,
            confirmText: "Scan",
            closeWhenDone: true,
            shakeItOff: 1
        ) {
            showScanner = true
        }
    }
}

#Preview {
    CardPrompt()
}
