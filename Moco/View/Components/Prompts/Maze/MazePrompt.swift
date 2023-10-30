//
//  MazePrompt.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 29/10/23.
//

import SwiftUI

struct MazePrompt: View {
    @State private var blurOpacity = 0.0
    @State private var showStartButton = false
    @State private var isStarted = false

    var promptText = "Moco adalah sapi jantan"

    func playPrompt() {
        isStarted = false
        withAnimation(.easeInOut(duration: 3)) {
            blurOpacity = 1
        } completion: {
            withAnimation(.easeInOut.delay(2)) {
                showStartButton = true
            }
        }
    }

    func stopPrompt() {
        withAnimation(.easeInOut(duration: 2)) {
            blurOpacity = 0
            showStartButton = false
        } completion: {
            withAnimation {
                isStarted = true
            }
        }
    }

    var body: some View {
        ZStack {
            MazeView()

            if !isStarted {
                VStack {
                    Text(promptText)
                        .customFont(.didactGothic, size: 30)
                        .foregroundColor(.text.primary)
                        .opacity(blurOpacity)
                    if showStartButton {
                        Button("Mulai") {
                            stopPrompt()
                        }
                        .buttonStyle(
                            MainButton(width: 80, height: 20)
                        )
                        .padding(.bottom, 20)
                    }
                }.frame(width: Screen.width, height: Screen.height).background(.ultraThinMaterial.opacity(blurOpacity))
            } else {
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            playPrompt()
                        } label: {
                            Image(systemName: "arrow.counterclockwise.circle")
                                .resizable()
                                .frame(width: 60, height: 60)
                        }
                        .buttonStyle(
                            CircleButton(width: 80, height: 80)
                        ).padding(40)
                    }
                    Spacer()
                }
            }
        }.onAppear {
            playPrompt()
        }
    }
}

#Preview {
    MazePrompt()
}
