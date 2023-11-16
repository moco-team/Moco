//
//  StoryView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 15/10/23.
//

import SwiftUI

struct StoryView: View {
    // MARK: - Environments stored property

    @Environment(\.storyThemeViewModel) private var storyThemeViewModel
    @Environment(\.storyViewModel) private var storyViewModel
    @Environment(\.episodeViewModel) private var episodeViewModel
    @Environment(\.storyContentViewModel) private var storyContentViewModel
    @Environment(\.promptViewModel) private var promptViewModel
    @Environment(\.hintViewModel) private var hintViewModel
    @Environment(\.mazePromptViewModel) private var mazePromptViewModel
    @Environment(\.timerViewModel) private var timerViewModel
    @Environment(\.audioViewModel) private var audioViewModel
    @Environment(\.settingsViewModel) private var settingsViewModel
    @Environment(\.navigate) private var navigate
    @EnvironmentObject var speechViewModel: SpeechRecognizerViewModel
    @EnvironmentObject var objectDetectionViewModel: ObjectDetectionViewModel
    @EnvironmentObject var arViewModel: ARViewModel

    // MARK: - Static Variables

    private static let storyVolume: Float = 0.5

    // MARK: - States

    @State private var scrollPosition: Int? = 0
    @State private var isExitPopUpActive = false
    @State private var isEpisodeFinished = false
    @State private var isMuted = false
    @State private var text: String = ""
    @State private var narrativeIndex: Int = -1
    @State private var showPromptButton = false
    @State private var activePrompt: PromptModel?
    @State private var peelEffectState = PeelEffectState.stop
    @State private var toBeExecutedByPeelEffect = {}
    @State private var peelBackground = AnyView(EmptyView())
    @State private var isReversePeel = false
    @State private var showWrongAnsPopup = false
    @State private var mazeQuestionIndex = 0
    @State private var forceShowNext = false
    @State private var showPauseMenu = false

    // MARK: - Variables

    var enableUI = true

    // MARK: - Functions

    private func updateText() {
        guard storyContentViewModel.narratives!.indices.contains(narrativeIndex + 1) else { return }
        narrativeIndex += 1
//        speechViewModel.textToSpeech(text: storyContentViewModel.narratives![narrativeIndex].contentName)
        timerViewModel.setTimer(key: "storyPageTimer-\(narrativeIndex)-\(scrollPosition!)", withInterval: storyContentViewModel.narratives![narrativeIndex].duration) {
            updateText()
        }
    }

    private func stop() {
        timerViewModel.stopTimer()
        audioViewModel.pauseAllSounds()
        speechViewModel.stopSpeaking()
    }

    private func startNarrative() {
        guard storyContentViewModel.narratives != nil else { return }
        narrativeIndex = -1
        updateText()
    }

    private func startPrompt() {
        if let storyPage = storyViewModel.storyPage, !storyPage.earlyPrompt {
            activePrompt = nil
        }
        guard let prompts = promptViewModel.prompts, !prompts.isEmpty else {
            showPromptButton = false
            return
        }
        timerViewModel.setTimer(key: "storyPagePrompt-\(scrollPosition!)", withInterval: promptViewModel.prompts![0].startTime) {
            withAnimation {
                showPromptButton = true
            }
        }
    }

    private func onPageChange() {
        stop()
        setNewStoryPage(scrollPosition ?? -1)

        if let bgSound = storyContentViewModel.bgSound?.contentName {
            audioViewModel.playSound(
                soundFileName: bgSound,
                numberOfLoops: -1,
                category: .backsound
            )
        }

        startNarrative()
        if let storyPage = storyViewModel.storyPage {
            promptViewModel.fetchPrompts(storyPage)
        }
        startPrompt()
        if let storyPage = storyViewModel.storyPage, storyPage.earlyPrompt {
            promptViewModel.fetchPrompts(storyPage)
            if let prompt = promptViewModel.prompts?.first {
                activePrompt = prompt
            }
        }
    }

    private func nextPage() {
        guard episodeViewModel.selectedEpisode!.stories!.count > scrollPosition! + 1 else {
            isEpisodeFinished = true
            return
        }

        showPromptButton = false

        let nextPageBg = storyViewModel.getPageBackground(scrollPosition! + 1, episode: episodeViewModel.selectedEpisode!)

        peelBackground = AnyView(Image(nextPageBg ?? storyViewModel.storyPage!.background)
            .resizable()
            .scaledToFill()
            .frame(width: Screen.width, height: Screen.height, alignment: .center)
            .clipped())
        peelEffectState = .start
        toBeExecutedByPeelEffect = {
            scrollPosition! += 1
            peelEffectState = .stop
        }
    }

    private func prevPage(_ targetScrollPosition: Int? = nil) {
        guard scrollPosition! > 0 else { return }
        if let targetScrollPositionParam = targetScrollPosition {
            if targetScrollPositionParam < 0 {
                return
            }
        }
        isReversePeel = true
        if let targetScrollPositionParam = targetScrollPosition {
            scrollPosition = targetScrollPositionParam
        } else {
            scrollPosition! -= 1
        }
        peelEffectState = .reverse

        peelBackground = AnyView(Image(storyViewModel.storyPage!.background)
            .resizable()
            .scaledToFill()
            .frame(width: Screen.width, height: Screen.height, alignment: .center)
            .clipped())
        toBeExecutedByPeelEffect = {
            peelEffectState = .stop
            isReversePeel = false
        }
    }

    private func setNewStoryPage(_ scrollPosition: Int) {
        if scrollPosition > -1 {
            storyViewModel.fetchStory(scrollPosition, episodeViewModel.selectedEpisode!)

            if let storyPage = storyViewModel.storyPage {
                storyContentViewModel.fetchStoryContents(storyPage)

                promptViewModel.fetchPrompts(storyPage)

                if let prompts = promptViewModel.prompts, prompts.first?.hints != nil {
                    hintViewModel.fetchHints(prompts[0])
                }
            }
        }
    }

    // MARK: - View

    var body: some View {
        ZStack {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    if let stories = episodeViewModel.selectedEpisode!.stories {
                        ForEach(Array(stories.enumerated()), id: \.offset) { index, _ in
                            ZStack {
                                PeelEffectTappable(state: $peelEffectState, isReverse: isReversePeel) {
                                    Image(storyViewModel.storyPage!.background)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: Screen.width, height: Screen.height, alignment: .center)
                                        .clipped()
                                } background: {
                                    peelBackground
                                } onComplete: {
                                    toBeExecutedByPeelEffect()
                                }

                                if storyContentViewModel.narratives!.count > narrativeIndex && !storyContentViewModel.narratives!.isEmpty {
                                    let narrative = storyContentViewModel.narratives![max(narrativeIndex, 0)]
                                    Text(narrative.contentName)
                                        .foregroundColor(Color(hex: narrative.color ?? "#000000"))
                                        .frame(maxWidth: CGFloat(narrative.maxWidth!), alignment: .leading)
                                        .position(CGPoint(
                                            x: Screen.width * narrative.positionX,
                                            y: Screen.height * narrative.positionY
                                        ))
                                        .id(narrativeIndex)
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
                .scrollPosition(id: $scrollPosition)
            if let stories = episodeViewModel.selectedEpisode?.stories {
                Group {
                    switch activePrompt?.promptType {
                    case .card:
                        if let cardPrompt = promptViewModel.prompts?.first {
                            CardPrompt(showNext: $forceShowNext) {
                                nextPage()
                            }
                            .id(cardPrompt.id)
                        }
                    case .multipleChoice:
                        if promptViewModel.prompts != nil {
                            MultipleChoicePrompt {
                                activePrompt = nil
                                nextPage()
                            } onWrong: {
                                showWrongAnsPopup = true
                            }
                        }
                    case .maze:
                        if let mazePrompt = promptViewModel.prompts?.first {
                            MazePrompt(
                                promptText: mazePrompt.question!,
                                answersAsset: mazePrompt.answerAssets!,
                                answers: mazePrompt.answerChoices!,
                                correctAnswerAsset: mazePrompt.correctAnswer,
                                promptId: mazePrompt.uid
                            ) {
                                nextPage()
                            }.id(mazePrompt.id)
                        }
                    case .ar:
                        if let ARPrompt = promptViewModel.prompts?[0] {
                            ARStory(
                                prompt: ARPrompt,
                                lastPrompt: scrollPosition == (stories.count - 1)
                            ) {
                                nextPage()
                            }
                            .id(ARPrompt.id)
                            .onAppear {
                                print("nih AR")
                                print(promptViewModel.prompts![0].correctAnswer)
                            }
                        }
                    case .objectDetection:
                        DetectionView {
                            nextPage()
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
                            isExitPopUpActive = true
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
                            if !isMuted {
                                audioViewModel.mute()
                            } else {
                                audioViewModel.unmute()
                            }
                            isMuted.toggle()
                        } label: {
                            Image(isMuted ? "Buttons/sound-off" : "Buttons/sound-on")
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
                            showPauseMenu = true
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
                    if scrollPosition! > 0 {
                        StoryNavigationButton(direction: .left) {
                            prevPage()
                        }
                    }
                    Spacer()

                    if promptViewModel.prompts == nil ||
                        promptViewModel.prompts!.isEmpty ||
                        forceShowNext
                    {
                        StoryNavigationButton(direction: .right) {
                            nextPage()
                        }
                    }
                }.opacity(activePrompt == nil ? 1 : 0.5)
                VStack {
                    Spacer()
                    if showPromptButton && activePrompt == nil {
                        SfxButton {
                            activePrompt = promptViewModel.prompts![0]
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
        .popUp(isActive: $isExitPopUpActive, title: "Petualangan Moco belum selesai!. Petualangan Moco akan terulang dari awal. Yakin mau keluar?", cancelText: "Tidak", confirmText: "Ya") {
            navigate.pop {
                stop()
            }
        }
        .popUp(isActive: $isEpisodeFinished, title: "Petualangan Moco sebentar lagi selesai!. Lanjutkan petualangan?", cancelText: "Tidak", confirmText: "Lanjut") {
            episodeViewModel.setToAvailable(selectedStoryTheme: storyThemeViewModel.selectedStoryTheme!)
            storyThemeViewModel.fetchStoryThemes()
            storyThemeViewModel.setSelectedStoryTheme(storyThemeViewModel.findWithID(storyThemeViewModel.selectedStoryTheme!.uid)!)
            navigate.pop {
                stop()
            }
        }
        .overlay {
            if showPauseMenu {
                if let promptType = activePrompt?.promptType {
                    PauseMenu(isActive: $showPauseMenu) {
                        switch promptType {
                        case .maze:
                            settingsViewModel.mazeTutorialFinished = false
                        case .findHoney:
                            break
                        case .objectDetection:
                            break
                        case .speech:
                            break
                        case .multipleChoice:
                            break
                        case .ar:
                            settingsViewModel.arTutorialFinished = false
                        case .card:
                            break
                        case .puzzle:
                            break
                        }
                    } repeatHandler: {
                        prevPage(0)
                    }
                }
            } else {
                EmptyView()
            }
        }
        .customModal(isActive: $showWrongAnsPopup, title: "Apakah kamu yakin dengan jawaban ini? Coba cek kembali pertanyaannya", textColor: Color.brownTxt) {
            activePrompt = nil
            showWrongAnsPopup = false
        }
        .task {
            onPageChange()
            mazePromptViewModel.reset(true)
//            arViewModel.resetStates()
        }
        .task(id: scrollPosition) {
            onPageChange()
        }
    }
}

#Preview {
    @State var timerViewModel = TimerViewModel()
    @State var audioViewModel = AudioViewModel()
    @StateObject var speechViewModel = SpeechRecognizerViewModel.shared

    return StoryView()
        .environment(\.timerViewModel, timerViewModel)
        .environment(\.audioViewModel, audioViewModel)
        .environmentObject(speechViewModel)
}
