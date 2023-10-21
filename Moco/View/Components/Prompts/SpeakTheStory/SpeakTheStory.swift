//
//  SpeakTheStory.swift
//  Moco
//
//  Created by Carissa Farry Hilmi Az Zahra on 19/10/23.
//

import SwiftUI

struct SpeakTheStory: View {
    @ObservedObject var speechRecognizerViewModel = SpeechRecognizerViewModel.shared

//    @Binding var isPromptDone: Bool
    @State var isPromptDone: Bool = false

//    let hints: [String]
    @State private var correctAnswer: String = "mengapa maudi menangis"

    @State private var audio: String = "Page3-monolog1"
    @State private var showPopUp = false
    @State private var isRecording = false

    var doneHandler: (() -> Void)?

    private func isCorrectAnswer() -> Bool {
        let filteredAnswer = correctAnswer
            .filter { !$0.isWhitespace }
            .lowercased()
        return speechRecognizerViewModel.transcript
            .filter { !$0.isWhitespace }
            .lowercased()
            .contains(filteredAnswer) ||
            speechRecognizerViewModel.possibleTranscripts
            .contains { transcript in
                transcript
                    .filter { !$0.isWhitespace }
                    .lowercased()
                    .contains(filteredAnswer)
            }
    }

    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Spacer()

            Text("Transcribed Text: \(speechRecognizerViewModel.transcript)")
                .foregroundStyle(.white)
                .padding()

            Button(action: {
                if isRecording {
                    speechRecognizerViewModel.stopTranscribing()
                } else {
                    speechRecognizerViewModel.transcribe()
                }
                isRecording.toggle()
            }) {
                Image("Story/Icons/mic")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .padding()
                    .background(Circle().foregroundColor(!isRecording ? Color.greenBtn : .gray))
            }

            Spacer()
        }
        .onChange(of: speechRecognizerViewModel.transcript) {
            if isCorrectAnswer() {
                print("Benar!")
                showPopUp = true
            }
        }
        .popUp(isActive: $showPopUp, title: "Benar! Maudi sedang menangis!") {
            isPromptDone = true
            doneHandler?()
        }
    }
}

#Preview {
    SpeakTheStory(
        //        isPromptDone: .constant(false)
//        hints: ["Page3-monolog1"]
//        correctAnswer: "Page3-monolog1"
    )
}
