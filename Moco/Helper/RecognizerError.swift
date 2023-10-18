//
//  RecognizerError.swift
//  Moco
//
//  Created by Daniel Aprillio on 17/10/23.
//

import Foundation

enum RecognizerError: Error {
    case nilRecognizer
    case notAuthorizedToRecognize
    case notPermittedToRecord
    case recognizerIsUnavailable
}

extension RecognizerError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .nilRecognizer:
            return "Can't initialize speech recognizer"
        case .notAuthorizedToRecognize:
            return "Not authorized to recognize speech"
        case .notPermittedToRecord:
            return "Not permitted to record audio"
        case .recognizerIsUnavailable:
            return "Recognizer is unavailable"
        }
    }
}
