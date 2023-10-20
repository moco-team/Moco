//
//  SpeakTheStory.swift
//  Moco
//
//  Created by Carissa Farry Hilmi Az Zahra on 19/10/23.
//

import SwiftUI

struct SpeakTheStory: View {
    @ObservedObject var speechRecognizerViewModel = SpeechRecognizerViewModel.shared

    @State private var isRecording = false

    var body: some View {
        Text("Transcribed Text: \(speechRecognizerViewModel.transcript)")
            .foregroundStyle(.gray)
            .padding()

        Button(action: {
            if isRecording {
                speechRecognizerViewModel.stopTranscribing()
            } else {
                speechRecognizerViewModel.transcribe()
            }
            isRecording.toggle()
        }) {
            Text(isRecording ? "Stop Transcription" : "Start Transcription")
                .font(.title)
                .padding()
        }
    }
}

#Preview {
    SpeakTheStory()
}
