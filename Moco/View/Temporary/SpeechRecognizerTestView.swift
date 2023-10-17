//
//  SpeechRecognizerTestView.swift
//  Moco
//
//  Created by Daniel Aprillio on 17/10/23.
//

import SwiftUI

struct SpeechRecognizerTestView: View {
    
    @ObservedObject var speechRecognizerViewModel = SpeechRecognizerViewModel.shared
    
    @State private var textToSpeech: String = ""
    @State private var isRecording = false
    
    var body: some View {
        VStack {
            Spacer()
            Group{
                Text("Text-To-Speech")
                TextField("Write something...", text: $textToSpeech)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button("Speak Text") {
                    speechRecognizerViewModel.textToSpeech(text: textToSpeech)
                }
            }
            Spacer()
            Group{
                Text("Speech-To-Text")
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
            Spacer()
        }
    }
}

#Preview {
    SpeechRecognizerTestView()
}
