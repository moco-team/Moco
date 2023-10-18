//
//  TimerModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 17/10/23.
//

import Foundation

struct TimerModel {
    var internalTimer: Timer?
    var jobs = [() -> Void]()

    mutating func clearJobs() {
        jobs = []
    }

    func pauseTimer() {
        guard internalTimer != nil else {
            print("No timer active, start the timer before you stop it.")
            return
        }
        internalTimer?.invalidate()
    }

    mutating func stopTimer() {
        guard internalTimer != nil else {
            print("No timer active, start the timer before you stop it.")
            return
        }
        jobs = [() -> Void]()
        internalTimer?.invalidate()
    }
}
