//
//  MazePrompt.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 29/10/23.
//

import SwiftUI

struct MazePrompt: View {
    @Environment(\.settingsViewModel) private var settingsViewModel
    @Environment(\.audioViewModel) private var audioViewModel
    @State private var mazePromptViewModel = MazePromptViewModel()

    var promptText = "Moco adalah sapi jantan"
    var answersAsset = ["Maze/answer_one", "Maze/answer_two"]
    var answers = ["satu", "dua", "tiga"]
    var correctAnswerAsset = "Maze/answer_three"
    var initialTime = 60 * 3

    var action: () -> Void = {}

    func playInitialNarration() {
        if mazePromptViewModel.isTutorialDone {
            audioViewModel.playSound(soundFileName: "013 (maze) - bantu arahkan Moco ke jawaban yang benar ya", type: .m4a, category: .narration)
        }
    }

    var body: some View {
        ZStack {
            ZStack {
                VStack {
                    HStack {
                        MazeProgress(progress: $mazePromptViewModel.progress)
                        Spacer()
                        TimerView().padding(.trailing, Screen.width * 0.2)
                    }
                    Text(promptText)
                        .customFont(.didactGothic, size: 40)
                        .foregroundColor(.text.brown)
                    Spacer()
                    MazeView(
                        answersAsset: answersAsset,
                        answers: answers,
                        correctAnswerAsset: correctAnswerAsset,
                        correctAnswer: $mazePromptViewModel.isCorrectAnswer,
                        wrongAnswer: $mazePromptViewModel.isWrongAnswer,
                        isTutorialDone: $mazePromptViewModel.isTutorialDone
                    ) {
                        action()
                    }.padding(.bottom, 20)
                        .id(promptText)
                }
                .ignoresSafeArea()
                .frame(width: Screen.width, height: Screen.height)
                if !mazePromptViewModel.isTutorialDone {
                    MazeTutorialView(isTutorialDone: $mazePromptViewModel.isTutorialDone)
                }
            }
        }.background {
            Image("Maze/bg-texture").resizable().scaledToFill().overlay {
                Color.yellow.opacity(0.3)
            }
        }
        .ignoresSafeArea()
        .frame(width: Screen.width, height: Screen.height)
        .onChange(of: mazePromptViewModel.isTutorialDone) {
            print("Kuntul")
            playInitialNarration()
        }
        .onAppear {
            playInitialNarration()
        }
        .popUp(isActive: $mazePromptViewModel.isCorrectAnswer, title: "Selamat kamu berhasil", withConfetti: true) {
            action()
        }
        .popUp(isActive: $mazePromptViewModel.isWrongAnswer, title: "Oh tidak! Kamu pergi ke jalan yang salah") {
            action()
        }
        .forceRotation()
    }
}

struct MazePromptOld: View {
    @State private var mazePromptViewModel = MazePromptViewModel()

    var promptText = "Moco adalah sapi jantan"
    var answersAsset = ["Maze/answer_one", "Maze/answer_two"]
    var correctAnswerAsset = "Maze/answer_three"

    var action: () -> Void = {}

    var body: some View {
        ZStack {
            MazeView(answersAsset: answersAsset,
                     correctAnswerAsset: correctAnswerAsset,
                     correctAnswer: .constant(true),
                     wrongAnswer: .constant(false),
                     isTutorialDone: .constant(true)) {
                action()
            }

            if !mazePromptViewModel.isStarted {
                VStack {
                    Text(promptText)
                        .customFont(.didactGothic, size: 30)
                        .foregroundColor(.text.primary)
                        .opacity(mazePromptViewModel.blurOpacity)
                        .background {
                            Image("Components/modal-base-lg").resizable().scaledToFill().padding(-20)
                        }
                        .frame(width: Screen.width * 0.7, height: 0.4 * Screen.height)
                    if mazePromptViewModel.showStartButton {
                        SfxButton {
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
                }.frame(width: Screen.width, height: Screen.height)
                    .background(.ultraThinMaterial.opacity(mazePromptViewModel.blurOpacity))
            } else {
                VStack {
                    HStack {
                        Spacer()
                        SfxButton {
                            mazePromptViewModel.playPrompt()
                        } label: {
                            Image("Buttons/button-question")
                                .resizable()
                                .frame(width: 76, height: 76)
                        }
                        .buttonStyle(
                            CircleButton(width: 80, height: 80, backgroundColor: .clear)
                        )
                        .opacity(0.6)
                        .padding(40)
                        .padding(.top, 60)
                    }
                    Spacer()
                }
            }
        }.onLoad {
            mazePromptViewModel.playPrompt()
        }.forceRotation()
    }
}

#Preview {
    MazePrompt()
}
