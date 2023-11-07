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

//    let hints: [String]

    @State private var speakPromptViewModel = SpeakPromptViewModel()

    var doneHandler: (() -> Void)?

    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Spacer()

            Button(action: {
                speakPromptViewModel.showHint.toggle()
            }) {
                Text("Petunjuk")
                    .foregroundStyle(Color.brownTxt)
            }

            if speakPromptViewModel.showHint {
                Text("Maudi sedang menangis")
                    .foregroundStyle(.white)
            }

            Text("\(speechRecognizerViewModel.transcript)")
                .foregroundStyle(.white)
                .padding()

            Button(action: {
                if speakPromptViewModel.isRecording {
                    speechRecognizerViewModel.stopTranscribing()
                } else {
                    speechRecognizerViewModel.transcribe()
                }
                speakPromptViewModel.isRecording.toggle()
            }) {
                Image("Story/Icons/mic")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .padding()
                    .background(Circle().foregroundColor(!speakPromptViewModel.isRecording ? Color.greenBtn : .gray))
            }

            Spacer()
        }
        .onChange(of: speechRecognizerViewModel.transcript) {
            if speakPromptViewModel.isCorrectAnswer(speechRecognizerViewModel.transcript, possibleTranscripts: speechRecognizerViewModel.possibleTranscripts) {
                print("Benar!")
                audioViewModel.playSound(soundFileName: "success", category: .soundEffect)
                speechRecognizerViewModel.stopTranscribing()
                speakPromptViewModel.showPopUp = true
            }
        }
        .popUp(isActive: $speakPromptViewModel.showPopUp, title: "Benar! Maudi sedang menangis!") {
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
