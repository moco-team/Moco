//
//  SpeakPromptModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 22/10/23.
//

import Foundation

struct SpeakPromptModel {
    var correctAnswer: String = "maudi sedang menangis"

    var audio: String = "Page3-monolog1"
    var showPopUp = false
    var isRecording = false
    var showHint = false

    func isCorrectAnswer(transcript: String, possibleTranscripts: [String] = []) -> Bool {
        let filteredAnswer = correctAnswer
            .filter { !$0.isWhitespace }
            .lowercased()
        return transcript
            .filter { !$0.isWhitespace }
            .lowercased()
            .contains(filteredAnswer) ||
            possibleTranscripts
            .contains { transcript in
                transcript
                    .filter { !$0.isWhitespace }
                    .lowercased()
                    .contains(filteredAnswer)
            }
    }
}
