//
//  SFSpeechRecognizerExtension.swift
//  Moco
//
//  Created by Daniel Aprillio on 17/10/23.
//

import Foundation
import Speech

extension SFSpeechRecognizer {
    static func hasAuthorizationToRecognize() async -> Bool {
        await withCheckedContinuation { continuation in
            requestAuthorization { status in
                continuation.resume(returning: status == .authorized)
            }
        }
    }
}
