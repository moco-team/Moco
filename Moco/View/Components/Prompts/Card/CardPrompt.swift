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
    @Environment(\.storyViewModel) private var storyViewModel

    @State private var currentCard = 0
    @State private var showQuestionPopup = false
    @State private var questionPopup = ""
    @State private var showScanner = false

    @Binding var showNext: Bool

    var onComplete: (() -> Void)?

    var body: some View {
        ZStack {
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
                        type: cardPrompt.cardType
                    ) {
                        questionPopup = cardPrompt.question!
                        showQuestionPopup = true
                    }
                    .position(
                        CGPoint(
                            x: Screen.width * cardPrompt.cardLocationX,
                            y: Screen.height * cardPrompt.cardLocationY
                        )
                    )
                }
            }
            if let cardQuestions = storyViewModel.getStoryContentByType(.text),
               cardQuestions.count > currentCard {
                let promptContent = cardQuestions[currentCard]
                VStack {


                    Text(promptContent.text)
                        .customFont(.didactGothic, size: 40)

                }
                .position(
                    CGPoint(
                        x: Screen.width * promptContent.positionX,
                        y: Screen.height * promptContent.positionY
                    )
                )
            }
            if showScanner {
                CardScan {
                    currentCard += 1
                    showScanner = false
                    if let prompts = promptViewModel.prompts, currentCard >= prompts.count {
                        showNext = true
                        onComplete?()
                    }
                }
            }
        }
        .onAppear {
            currentCard = 0
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
    CardPrompt(showNext: .constant(true))
}
