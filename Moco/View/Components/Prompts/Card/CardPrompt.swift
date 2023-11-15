//
//  CardPrompt.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 13/11/23.
//

import SwiftUI

enum CardState: String, Codable {
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
                    if let cardPrompts = promptViewModel.prompts {
                        ForEach(Array(cardPrompts.enumerated()), id: \.offset) { index, cardPrompt in
                            CardView(
                                state: index < currentCard ?
                                    .revealed :
                                    index == currentCard ?
                                    .active :
                                        .inactive,
                                revealedImage: cardPrompt.imageCard!,
                                text: cardPrompt.correctAnswer,
                                suffix: cardPrompt.correctAnswer == "Teka dan Teki" ? "" : ","
                            ) {
                                questionPopup = cardPrompt.question!
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
