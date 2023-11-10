//
//  TimerModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 17/10/23.
//

import Foundation

struct TimerModel {
    var internalTimer: [String: Timer?] = [:]
    var jobs: [String: () -> Void] = [:]

    mutating func clearJobs() {
        jobs = [:]
    }

    func pauseTimer() {
        guard internalTimer.contains(where: { $1 != nil }) else {
            print("No timer active, start the timer before you stop it.")
            return
        }
        internalTimer.forEach {
            $1?.invalidate()
        }
    }

    mutating func stopTimer(_ key: String) {
        guard internalTimer.contains(where: { $0.key == key }) else {
            print("Timer with key \(key) not found")
            return
        }

        internalTimer[key]??.invalidate()

        internalTimer.removeValue(forKey: key)

        jobs.removeValue(forKey: key)
    }

    mutating func stopTimer() {
        guard internalTimer.contains(where: { $1 != nil }) else {
            print("No timer active, start the timer before you stop it.")
            return
        }
        clearJobs()
        internalTimer.forEach {
            $1?.invalidate()
        }
        internalTimer = [:]
    }
}
