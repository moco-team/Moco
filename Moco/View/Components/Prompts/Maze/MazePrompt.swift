//
//  MazePrompt.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 29/10/23.
//

import SwiftUI

struct MazePrompt: View {
    @State private var mazePromptViewModel = MazePromptViewModel()

    var promptText = "Moco adalah sapi jantan"

    var body: some View {
        ZStack {
            MazeView()

            if !mazePromptViewModel.isStarted {
                VStack {
                    Text(promptText)
                        .customFont(.didactGothic, size: 30)
                        .foregroundColor(.text.primary)
                        .opacity(mazePromptViewModel.blurOpacity)
                    if mazePromptViewModel.showStartButton {
                        Button {
                            mazePromptViewModel.stopPrompt()
                        } label: {
                            Image("Buttons/button-start").resizable().scaledToFit()
                        }
                        .buttonStyle(
                            CapsuleButton(
                                width: 190,
                                height: 90,
                                backgroundColor: .clear,
                                foregroundColor: .clear
                            )
                        )
                        .padding(.bottom, 20)
                    }
                }.frame(width: Screen.width, height: Screen.height).background(.ultraThinMaterial.opacity(mazePromptViewModel.blurOpacity))
            } else {
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            mazePromptViewModel.playPrompt()
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
            mazePromptViewModel.playPrompt()
        }
    }
}

#Preview {
    MazePrompt()
}
