//
//  StoryView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 15/10/23.
//

import SwiftUI

struct StoryView: View {
    // MARK: - States

    @Bindable private var svvm = StoryViewViewModel()

    // MARK: - View

    var body: some View {
        ZStack {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    if let stories = svvm.episodeViewModel.selectedEpisode!.stories {
                        ForEach(Array(stories.enumerated()), id: \.offset) { index, _ in
                            ZStack {
                                PeelEffectTappable(state: $svvm.peelEffectState, isReverse: svvm.isReversePeel) {
                                    Image(svvm.storyViewModel.storyPage!.background)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: Screen.width, height: Screen.height, alignment: .center)
                                        .clipped()
                                } background: {
                                    svvm.peelBackground
                                } onComplete: {
                                    svvm.toBeExecutedByPeelEffect()
                                }

                                if svvm.storyContentViewModel.narratives!.count > svvm.narrativeIndex &&
                                    !svvm.storyContentViewModel.narratives!.isEmpty {
                                    let narrative = svvm.storyContentViewModel.narratives![max(svvm.narrativeIndex, 0)]
                                    Text(narrative.contentName)
                                        .foregroundColor(Color(hex: narrative.color ?? "#000000"))
                                        .frame(maxWidth: CGFloat(narrative.maxWidth!), alignment: .leading)
                                        .position(CGPoint(
                                            x: Screen.width * narrative.positionX,
                                            y: Screen.height * narrative.positionY
                                        ))
                                        .id(svvm.narrativeIndex)
                                        .transition(.opacity.animation(.linear))
                                        .customFont(.didactGothic, size: narrative.fontSize)
                                        .padding(.bottom, 2)
                                }
                            }.id(index)
                        }
                    }
                }.scrollTargetLayout()
            }.scrollDisabled(true)
                .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
                .scrollPosition(id: $svvm.scrollPosition)
            if let stories = svvm.episodeViewModel.selectedEpisode?.stories {
                Group {
                    switch svvm.activePrompt?.promptType {
                    case .card:
                        if let cardPrompt = svvm.promptViewModel.prompts?.first {
                            CardPrompt(showNext: $svvm.forceShowNext) {
                                svvm.nextPage()
                            }
                            .id(cardPrompt.id)
                        }
                    case .multipleChoice:
                        if svvm.promptViewModel.prompts != nil {
                            MultipleChoicePrompt {
                                svvm.activePrompt = nil
                                svvm.nextPage()
                            } onWrong: {
                                svvm.showWrongAnsPopup = true
                            }
                        }
                    case .maze:
                        if let mazePrompt = svvm.promptViewModel.prompts?.first {
                            MazePrompt(
                                promptText: mazePrompt.question!,
                                answersAsset: mazePrompt.answerAssets!,
                                answers: mazePrompt.answerChoices!,
                                correctAnswerAsset: mazePrompt.correctAnswer,
                                promptId: mazePrompt.uid
                            ) {
                                svvm.nextPage()
                            }.id(mazePrompt.id)
                        }
                    case .ar:
                        if let ARPrompt = svvm.promptViewModel.prompts?[0] {
                            ARStory(
                                prompt: ARPrompt,
                                lastPrompt: svvm.scrollPosition == (stories.count - 1)
                            ) {
                                svvm.nextPage()
                            }
                            .id(ARPrompt.id)
                            .onAppear {
                                print("nih AR")
                                print(svvm.promptViewModel.prompts![0].correctAnswer)
                            }
                        }
                    case .objectDetection:
                        DetectionView {
                            svvm.nextPage()
                        }
                    default:
                        EmptyView()
                    }
                }
            }
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        SfxButton {
                            svvm.isExitPopUpActive = true
                        } label: {
                            Image("Buttons/button-home").resizable().scaledToFit()
                        }.buttonStyle(
                            CircleButton(
                                width: 80,
                                height: 80,
                                backgroundColor: .clear,
                                foregroundColor: .clear
                            )
                        )
                        .padding()
                        SfxButton {
                            svvm.onPressSoundButton()
                        } label: {
                            Image(svvm.isMuted ? "Buttons/sound-off" : "Buttons/sound-on")
                                .resizable()
                                .scaledToFit()
                        }.buttonStyle(
                            CircleButton(
                                width: 80,
                                height: 80,
                                backgroundColor: .clear,
                                foregroundColor: .clear
                            )
                        )
                        .padding()
                        SfxButton {
                            svvm.showPauseMenu = true
                        } label: {
                            Image("Buttons/button-settings")
                                .resizable()
                                .scaledToFit()
                        }.buttonStyle(
                            CircleButton(
                                width: 80,
                                height: 80,
                                backgroundColor: .clear,
                                foregroundColor: .clear
                            )
                        )
                        .padding()
                    }
                    Spacer()
                }
                HStack {
                    if svvm.scrollPosition! > 0 {
                        StoryNavigationButton(direction: .left) {
                            svvm.prevPage()
                        }
                    }
                    Spacer()

                    if svvm.promptViewModel.prompts == nil ||
                        svvm.promptViewModel.prompts!.isEmpty ||
                        svvm.forceShowNext {
                        StoryNavigationButton(direction: .right) {
                            svvm.nextPage()
                        }
                    }
                }.opacity(svvm.activePrompt == nil ? 1 : 0.5)
                VStack {
                    Spacer()
                    if svvm.showPromptButton && svvm.activePrompt == nil {
                        SfxButton {
                            svvm.activePrompt = svvm.promptViewModel.prompts![0]
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
                }
            }
        }
        .popUp(isActive: $svvm.isExitPopUpActive, title: "Yakin mau keluar?", cancelText: "Tidak", confirmText: "Ya") {
            svvm.exit()
        }
        .popUp(isActive: $svvm.isEpisodeFinished, title: "Lanjutkan cerita?", cancelText: "Tidak", confirmText: "Lanjut") {
            svvm.continueStory()
        }
        .overlay {
            if svvm.showPauseMenu {
                if let promptType = svvm.activePrompt?.promptType {
                    PauseMenu(isActive: $svvm.showPauseMenu) {
                        switch promptType {
                        case .maze:
                            svvm.settingsViewModel.mazeTutorialFinished = false
                        case .findHoney:
                            break
                        case .objectDetection:
                            break
                        case .speech:
                            break
                        case .multipleChoice:
                            break
                        case .ar:
                            svvm.settingsViewModel.arTutorialFinished = false
                        case .card:
                            break
                        case .puzzle:
                            break
                        }
                    } repeatHandler: {
                        svvm.prevPage(0)
                    }
                }
            } else {
                EmptyView()
            }
        }
        .customModal(isActive: $svvm.showWrongAnsPopup, title: "Apakah kamu yakin dengan jawaban ini? Coba cek kembali pertanyaannya", textColor: Color.brownTxt) {
            svvm.activePrompt = nil
            svvm.showWrongAnsPopup = false
        }
        .task {
            svvm.onAppear()
//            arViewModel.resetStates()
        }
        .task(id: svvm.scrollPosition) {
            svvm.onPageChange()
        }
    }
}

#Preview {
    @State var timerViewModel = TimerViewModel()
    @State var audioViewModel = AudioViewModel()

    return StoryView()
        .environment(\.timerViewModel, timerViewModel)
        .environment(\.audioViewModel, audioViewModel)
}
