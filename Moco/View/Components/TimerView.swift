//
//  TimerView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 06/11/23.
//

import SwiftUI

struct TimerPlayground: View {
    @State var isTimerRunning = false
    @State private var durationInSeconds = 60 * 5
    @State var interval = TimeInterval()

    var durationParamInSeconds = 60 * 5

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private var currentSecond: Int {
        durationInSeconds % 60
    }

    private var currentMinute: Int {
        durationInSeconds / 60
    }

    private var formattedTimer: String {
        String(format: "%02d:%02d", currentMinute, currentSecond)
    }

    var body: some View {
        VStack {
            Text(formattedTimer)
                .font(Font.system(.largeTitle, design: .monospaced))
                .onReceive(timer) { _ in
                    if self.isTimerRunning && durationInSeconds > 0 {
                        durationInSeconds -= 1
                    }
                }
                .onAppear {
                    durationInSeconds = durationParamInSeconds
                    isTimerRunning.toggle()
                }
            Text("-5s")
                .font(Font.system(.title, design: .monospaced))
                .foregroundColor(.red)
        }
    }
}

#Preview {
    TimerPlayground(durationParamInSeconds: 60 * 6)
}
