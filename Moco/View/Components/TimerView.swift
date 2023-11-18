//
//  TimerView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 06/11/23.
//

import SwiftUI

struct CircularTimerView: View {
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
            CircularProgressView(progress: Double(durationInSeconds) / Double(durationParamInSeconds), dynamicColor: true) { _ in
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
            }
//            Text("-5s")
//                .font(Font.system(.title, design: .monospaced))
//                .foregroundColor(.red)
        }
    }
}

struct TimerView: View {
    @State var isTimerRunning = false
    @State private var durationInSeconds = 60 * 5
    @State private var shouldShake: CGFloat = 0
    @State var interval = TimeInterval()

    var durationParamInSeconds = 60 * 5

    var onEnd: (() -> Void)?

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
                .customFont(.cherryBomb, size: 35)
                .foregroundColor(.text.darkBlue)
                .onReceive(timer) { _ in
                    if self.isTimerRunning && durationInSeconds > 0 {
                        durationInSeconds -= 1
                        if durationInSeconds <= 10 {
                            shouldShake = 1
                        }
                        if durationInSeconds <= 0 {
                            onEnd?()
                        }
                    }
                }
                .onAppear {
                    durationInSeconds = durationParamInSeconds
                    isTimerRunning.toggle()
                }
                .padding(14)
                .background {
                    Image("Components/timer-base").resizable()
                }
        }.padding()
            .shake(animatableData: shouldShake)
    }
}

struct TimerViewPreview: View {
    var body: some View {
        VStack(spacing: 50) {
            CircularTimerView()
            TimerView()
        }
    }
}

#Preview {
    TimerViewPreview()
}
