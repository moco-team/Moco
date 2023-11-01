//
//  MultipleChoicePrompt.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 01/11/23.
//

import SwiftUI

struct MultipleChoicePrompt: View {
    var correctAnswerIndex = 0
    var answers = ["", "", ""]
    var question = """
Siapakah nama seekor anak sapi yang lucu?
    A.) Moco
    B.) Bebe
    C.) Teka dan Teki
"""

    var onCorrect: () -> () = {}
    var onWrong: () -> () = {}

    var body: some View {
        ZStack {
            Image("Story/Prompts/moco-board")
                .resizable()
                .scaledToFill()
                .frame(width: Screen.width, height: Screen.height, alignment: .center)
                .clipped()
            Text(question).customFont(.didactGothic, size: 20).position(CGPoint(x: 0.5 * Screen.width, y: 0.12 * Screen.height))

            BoardAnswer(label: "A", position: CGPoint(x: 0.21 * Screen.width, y: 0.5 * Screen.height)) {
                if correctAnswerIndex == 0 {
                    onCorrect()
                } else {
                    onWrong()
                }
            }

            BoardAnswer(label: "B", position: CGPoint(x: 0.5 * Screen.width, y: 0.62 * Screen.height)) {
                if correctAnswerIndex == 1 {
                    onCorrect()
                } else {
                    onWrong()
                }
            }

            BoardAnswer(label: "C", position: CGPoint(x: 0.79 * Screen.width, y: 0.5 * Screen.height)) {
                if correctAnswerIndex == 2 {
                    onCorrect()
                } else {
                    onWrong()
                }
            }
        }
    }
}

#Preview {
    MultipleChoicePrompt()
}
