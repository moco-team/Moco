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

struct Card: Identifiable {
    var text: String
    var image: String
    var suffix: String = ""
    var question: String

    var id = UUID().uuidString
}

struct CardPrompt: View {
    var cards: [Card] = [
        .init(
            text: "Moco",
            image: "Story/Content/Story1/Pages/Page1/moco-card",
            suffix: ",",
            question: "Siapakah anak sapi yang lucu?"
        ),
        .init(
            text: "Bebe",
            image: "Story/Content/Story1/Pages/Page1/bebe-card",
            suffix: ",",
            question: "Siapakah anak beruang yang polos?"
        ),
        .init(
            text: "Teka & Teki",
            image: "Story/Content/Story1/Pages/Page1/tekateki-card",
            question: "Siapakah yang disebut dengan si kembar?"
        )
    ]
    @State private var currentCard = 0
    @State private var showQuestionPopup = false
    @State private var questionPopup = ""
    @State private var showScanner = false

    var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 20) {
                    ForEach(Array(cards.enumerated()), id: \.offset) { index, card in
                        CardView(
                            state: index < currentCard ?
                                .revealed :
                                index == currentCard ?
                                .active :
                                .inactive,
                            revealedImage: card.image,
                            text: card.text,
                            suffix: card.suffix
                        ) {
                            questionPopup = card.question
                            showQuestionPopup = true
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
