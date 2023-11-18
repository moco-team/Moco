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
    @Environment(\.audioViewModel) private var audioViewModel

    @State private var currentCard = 0
    @State private var showQuestionPopup = false
    @State private var showWrongAnswerPopup = false
    @State private var questionPopup = ""
    @State private var showScanner = false
    @State private var scanResult: [String] = []

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
                if let cardPrompts = promptViewModel.prompts {
                    CardScan(scanResult: $scanResult) {
                        showScanner = false
                        scanResult = scanResult.map {
                            $0.fromBase64() ?? ""
                        }
                        if scanResult.joined(separator: " ")
                            .trimmingCharacters(in: .whitespacesAndNewlines) !=
                            cardPrompts[currentCard].correctAnswer {
                            audioViewModel.playSound(
                                soundFileName: "maaf_kartu_tidak_tepat",
                                type: .m4a,
                                category: .narration
                            )
                            showWrongAnswerPopup = true
                            return
                        }
                        
                        audioViewModel.playSound(
                            soundFileName: "bagus_berhasil_scan",
                            type: .m4a,
                            category: .narration
                        )

                        currentCard += 1
                        if let prompts = promptViewModel.prompts,
                           currentCard >= prompts.count {
                            showNext = true
                            onComplete?()
                        }
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
        .popUp(
            isActive: $showWrongAnswerPopup,
            title: "Belum tepat!\n" + questionPopup,
            confirmText: "Scan",
            closeWhenDone: true,
            shakeItOff: 1,
            type: .danger
        ) {
            showScanner = true
        }
    }
}

#Preview {
    CardPrompt(showNext: .constant(true))
}
