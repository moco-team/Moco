//
//  SpeakPromptViewModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 22/10/23.
//

import Foundation

@Observable
class SpeakPromptViewModel {
    private var speakPromptModel = SpeakPromptModel()

    var audio: String {
        get {
            speakPromptModel.audio
        }
        set {
            speakPromptModel.audio = newValue
        }
    }

    var correctAnswer: String {
        get {
            speakPromptModel.correctAnswer
        }
        set {
            speakPromptModel.correctAnswer = newValue
        }
    }

    var showPopUp: Bool {
        get {
            speakPromptModel.showPopUp
        }
        set {
            speakPromptModel.showPopUp = newValue
        }
    }

    var isRecording: Bool {
        get {
            speakPromptModel.isRecording
        }
        set {
            speakPromptModel.isRecording = newValue
        }
    }

    var showHint: Bool {
        get {
            speakPromptModel.showHint
        }
        set {
            speakPromptModel.showHint = newValue
        }
    }

    func isCorrectAnswer(_ transcript: String, possibleTranscripts: [String] = []) -> Bool {
        speakPromptModel.isCorrectAnswer(transcript: transcript, possibleTranscripts: possibleTranscripts)
    }
}
