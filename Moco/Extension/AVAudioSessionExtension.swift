//
//  AVAudioSessionExtension.swift
//  Moco
//
//  Created by Daniel Aprillio on 17/10/23.
//

import AVFoundation
import Foundation

extension AVAudioSession {
    func hasPermissionToRecord() async -> Bool {
        await withCheckedContinuation { continuation in
            AVAudioApplication.requestRecordPermission { authorized in
                continuation.resume(returning: authorized)
            }
        }
    }
}
