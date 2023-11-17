//
//  MultipleChoicePrompt.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 01/11/23.
//

import SwiftUI

// struct MultipleChoicePromptQnA {
//    var correctAnswerIndex = 0
//    var question = """
//    Siapakah nama seekor anak sapi yang lucu?
//    A.) Moco
//    B.) Bebe
//    C.) Teka dan Teki
//    """
// }

struct MultipleChoicePrompt: View {
    @Environment(\.promptViewModel) private var promptViewModel

    var onCorrect: () -> Void
    var onWrong: () -> Void = {
        print("Wrong")
    }

    var body: some View {
        Image("Story/Prompts/moco-board")
            .resizable()
            .scaledToFill()
            .clipped()
            .onTapGesture {}
            .overlay {
                Text(promptViewModel.prompts![0].question ?? "").customFont(.didactGothic, size: 20).position(CGPoint(x: 0.5 * Screen.width, y: 0.12 * Screen.height))
                BoardAnswer(label: "A", position: CGPoint(x: 0.21 * Screen.width, y: 0.5 * Screen.height)) {
                    if promptViewModel.prompts![0].correctAnswer == "0" {
                        onCorrect()
                    } else {}
                }

                BoardAnswer(label: "B", position: CGPoint(x: 0.5 * Screen.width, y: 0.62 * Screen.height)) {
                    if promptViewModel.prompts![0].correctAnswer == "1" {
                        onCorrect()
                    } else {}
                }

                BoardAnswer(label: "C", position: CGPoint(x: 0.79 * Screen.width, y: 0.5 * Screen.height)) {
                    if promptViewModel.prompts![0].correctAnswer == "2" {
                        onCorrect()
                    } else {}
                }
            }
    }
}

#Preview {
    MultipleChoicePrompt {
        print("Benar2")
    }
}
