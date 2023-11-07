//
//  TimerViewModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 17/10/23.
//

import SwiftUI

@Observable class TimerViewModel {
    private var timerModel = TimerModel()
    var timerSet: [String: Bool] = [:]

    /// Start a `timer` with a key
    /// - parameter:  `key`  It is a unique key that stores the timer and helps differentiate timers between the view
    /// - parameter:  `withInterval`  Sets the interval in which the timer will fire
    /// - parameter:  `andJob`  A function to be executed when interval ends
    func setTimer(key: String, withInterval interval: Double, andJob job: @escaping () -> Void) {
        if timerSet[key] != nil, timerSet[key]! {
            return
        }
        startTimer(withInterval: interval, andJob: job)
        timerSet[key] = true
    }

    /// Stops all the timer
    func stopTimer() {
        timerModel.clearJobs()
        timerModel.stopTimer()
        timerSet = [:]
    }

    /// Start a timer
    func startTimer(withInterval interval: Double, andJob job: @escaping () -> Void) {
        if timerModel.internalTimer != nil {
            timerModel.internalTimer?.invalidate()
        }
        timerModel.jobs.append(job)
        timerModel.internalTimer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(doJob), userInfo: nil, repeats: true)
    }

    func getTimerRemaining(_: String) {}

    @objc func doJob() {
        guard timerModel.jobs.count > 0 else { return }
        timerModel.jobs.forEach { job in
            job()
        }
    }
}
