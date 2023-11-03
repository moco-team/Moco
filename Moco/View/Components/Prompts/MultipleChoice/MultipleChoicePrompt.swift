//
//  MultipleChoicePrompt.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 01/11/23.
//

import SwiftUI

//struct MultipleChoicePromptQnA {
//    var correctAnswerIndex = 0
//    var question = """
//    Siapakah nama seekor anak sapi yang lucu?
//    A.) Moco
//    B.) Bebe
//    C.) Teka dan Teki
//    """
//}

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
            .frame(width: Screen.width, height: Screen.height, alignment: .center)
            .clipped()
            .onTapGesture {}
            .overlay {
                Text(promptViewModel.prompt!.question ?? "").customFont(.didactGothic, size: 20).position(CGPoint(x: 0.5 * Screen.width, y: 0.12 * Screen.height))
                BoardAnswer(label: "A", position: CGPoint(x: 0.21 * Screen.width, y: 0.5 * Screen.height)) {
                    if promptViewModel.prompt!.correctAnswer == "0" {
                        onCorrect()
                    } else {
                        onWrong()
                    }
                }
                
                BoardAnswer(label: "B", position: CGPoint(x: 0.5 * Screen.width, y: 0.62 * Screen.height)) {
                    if promptViewModel.prompt!.correctAnswer == "1" {
                        onCorrect()
                    } else {
                        onWrong()
                    }
                }
                
                BoardAnswer(label: "C", position: CGPoint(x: 0.79 * Screen.width, y: 0.5 * Screen.height)) {
                    if promptViewModel.prompt!.correctAnswer == "2" {
                        onCorrect()
                    } else {
                        onWrong()
                    }
                }
            }
    }
}

#Preview {
    MultipleChoicePrompt {
        print("Benar2")
    } onWrong: {
        print("Uasu")
    }
}
