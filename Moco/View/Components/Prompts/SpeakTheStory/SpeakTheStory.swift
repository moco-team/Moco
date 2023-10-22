//
//  SpeakTheStory.swift
//  Moco
//
//  Created by Carissa Farry Hilmi Az Zahra on 19/10/23.
//

import SwiftUI

struct SpeakTheStory: View {
    @Environment(\.audioViewModel) private var audioViewModel
    @ObservedObject var speechRecognizerViewModel = SpeechRecognizerViewModel.shared

//    @Binding var isPromptDone: Bool
    @State var isPromptDone: Bool = false

//    let hints: [String]
    @State private var correctAnswer: String = "maudi sedang menangis"

    @State private var audio: String = "Page3-monolog1"
    @State private var showPopUp = false
    @State private var isRecording = false
    @State private var showHint = false

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

            Button(action: {
                showHint = !showHint
            }) {
                Text("Petunjuk")
                    .foregroundStyle(Color.brownTxt)
            }
            
            if showHint {
                Text("Maudi sedang menangis")
                    .foregroundStyle(.white)
            }
            
            Text("\(speechRecognizerViewModel.transcript)")
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
                audioViewModel.playSound(soundFileName: "success")
                speechRecognizerViewModel.stopTranscribing()
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
