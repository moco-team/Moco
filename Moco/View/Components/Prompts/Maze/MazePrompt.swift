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
    @Environment(\.episodeViewModel) private var episodeViewModel
    @Environment(\.mazePromptViewModel) private var mazePromptViewModel

    @State private var isCorrectAnswerPopup = false
    @State private var isWrongAnswerPopup = false

    @State private var updateTimer = true
    @State private var elapsedSecond = 0

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var promptText = "Moco adalah sapi jantan"
    var answersAsset = ["Maze/answer_one", "Maze/answer_two"]
    var answers = ["satu", "dua", "tiga"]
    var correctAnswerAsset = "Maze/answer_three"
    var initialTime = 60 * 3
    var promptId = ""

    var action: () -> Void = {}

    func playInitialNarration() {
        if mazePromptViewModel.isTutorialDone {
            audioViewModel.playSound(
                soundFileName: "013 (maze) - bantu arahkan Moco ke jawaban yang benar ya", 
                type: .m4a,
                category: .narration
            )
        }
    }

    var body: some View {
        ZStack {
            ZStack {
                VStack {
                    HStack(alignment: .top) {
                        MazeProgress()
                        Spacer()
                        TimerView(
                            durationParamInSeconds: mazePromptViewModel.durationInSeconds
                        )
                        .padding(.trailing, Screen.width * 0.3)
                    }
                    Text(promptText)
                        .customFont(.didactGothic, size: UIDevice.isIPad ? 40 : 20)
                        .foregroundColor(.text.brown)
                    Spacer()
                    MazeView(
                        answersAsset: answersAsset,
                        answers: answers,
                        correctAnswerAsset: correctAnswerAsset
                    ) {
                        action()
                    }.padding(.bottom, UIDevice.isIPad ? 20 : 10)
                        .id(promptText)
                }
                .ignoresSafeArea()
                .frame(width: Screen.width, height: Screen.height)
                if !mazePromptViewModel.isTutorialDone {
                    MazeTutorialView()
                }
            }
        }.background {
            Image("Maze/bg-texture").resizable().scaledToFill().overlay {
                Color.yellow.opacity(0.3)
            }
            .ignoresSafeArea()
            .frame(width: Screen.width, height: Screen.height)
        }
        .ignoresSafeArea()
        .frame(width: Screen.width, height: Screen.height)
        .onChange(of: mazePromptViewModel.isTutorialDone) {
            playInitialNarration()
        }
        .onChange(of: mazePromptViewModel.isCorrectAnswer) {
            if mazePromptViewModel.isCorrectAnswer {
                updateTimer = false
                isCorrectAnswerPopup = true
                mazePromptViewModel.currentMazeIndex += 1
                mazePromptViewModel.durationInSeconds -= elapsedSecond - 15
            }
        }
        .onChange(of: mazePromptViewModel.isWrongAnswer) {
            if mazePromptViewModel.isWrongAnswer {
                updateTimer = false
                isWrongAnswerPopup = true
                mazePromptViewModel.incWrong()
                mazePromptViewModel.durationInSeconds -= elapsedSecond + 5
            }
        }
        .onAppear {
            mazePromptViewModel.reset()
            (mazePromptViewModel.progress,
             mazePromptViewModel.currentMazeIndex,
             mazePromptViewModel.mazeCount) = episodeViewModel.getMazeProgress(promptId: promptId)
            playInitialNarration()
        }
        .popUp(isActive: $isCorrectAnswerPopup, title: "Selamat kamu berhasil", withConfetti: true, disableCancel: true) {
            action()
        }
        .popUp(isActive: $isWrongAnswerPopup, title: "Oh tidak! Kamu pergi ke jalan yang salah", disableCancel: true) {
            action()
        }
        .onReceive(timer) { _ in
            if updateTimer {
                elapsedSecond += 1
            }
        }
        .forceRotation()
    }
}

struct MazePromptOld: View {
    @Environment(\.promptViewModel) private var promptViewModel
    @State private var mazePromptViewModel = MazePromptViewModel()

    var action: () -> Void = {}

    var body: some View {
        ZStack {
            MazeView(answersAsset: promptViewModel.prompts![0].answerAssets!,
                     correctAnswerAsset: promptViewModel.prompts![0].correctAnswer) {
                action()
            }

            if !mazePromptViewModel.isStarted {
                VStack {
                    Text(promptViewModel.prompts![0].question ?? "")
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
