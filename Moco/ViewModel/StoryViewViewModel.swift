//
//  StoryViewViewModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 19/11/23.
//

import SwiftUI

class StoryViewViewModel: ObservableObject {
    // MARK: - Environments stored property

    private(set) var userViewModel = UserViewModel.shared
    private(set) var storyThemeViewModel = StoryThemeViewModel.shared
    private(set) var storyViewModel = StoryViewModel.shared
    private(set) var episodeViewModel = EpisodeViewModel.shared
    private(set) var storyContentViewModel = StoryContentViewModel.shared
    private(set) var promptViewModel = PromptViewModel.shared
    private(set) var hintViewModel = HintViewModel.shared
    private(set) var mazePromptViewModel = MazePromptViewModel.shared
    private(set) var timerViewModel = TimerViewModel()
    private(set) var audioViewModel = AudioViewModel.shared
    private(set) var settingsViewModel = SettingsViewModel.shared
    private(set) var navigate = RouteViewModel.shared

    // MARK: - Static Variables

    private static let storyVolume: Float = 0.5

    // MARK: - States

    @Published var scrollPosition: Int? = 0
    @Published var isExitPopUpActive = false
    @Published var isEpisodeFinished = false
    @Published private(set) var isMuted = false
    @Published private var text: String = ""
    @Published var narrativeIndex: Int = -1
    @Published var showPromptButton = false
    @Published var activePrompt: PromptModel?
    @Published var peelEffectState = PeelEffectState.stop
    @Published private(set) var toBeExecutedByPeelEffect = {}
    private(set) var peelBackground = AnyView(EmptyView())
    @Published private(set) var isReversePeel = false
    @Published var showWrongAnsPopup = false
    @Published private var mazeQuestionIndex = 0
    @Published var forceShowNext = false
    @Published var showPauseMenu = false

    // MARK: - Variables

    @Published var enableUI = true

    // MARK: - Functions

    private func updateText() {
        guard storyContentViewModel.narratives!.indices.contains(narrativeIndex + 1) else { return }
        narrativeIndex += 1
        //        speechViewModel.textToSpeech(text: storyContentViewModel.narratives![narrativeIndex].contentName)
        timerViewModel.setTimer(key: "storyPageTimer-\(narrativeIndex)-\(scrollPosition!)", withInterval: storyContentViewModel.narratives![narrativeIndex].duration) {
            self.updateText()
        }
    }

    func stop() {
        timerViewModel.stopTimer()
        audioViewModel.pauseAllSounds(.backsound)
    }

    private func startNarrative() {
        guard storyContentViewModel.narratives != nil else { return }
        narrativeIndex = -1
//        updateText()
    }

    private func startPrompt() {
        if let storyPage = storyViewModel.storyPage, !storyPage.earlyPrompt {
            activePrompt = nil
        }
        guard let prompts = promptViewModel.prompts, !prompts.isEmpty else {
            showPromptButton = false
            return
        }

        withAnimation(Animation.default.delay(promptViewModel.prompts![0].startTime)) {
            self.showPromptButton = true
        }
    }

    func onPageChange() {
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

    func nextPage() {
        guard episodeViewModel.selectedEpisode!.stories!.count >
            scrollPosition! + 1
        else {
            isEpisodeFinished = true
            return
        }

        showPromptButton = false
        forceShowNext = false

        let nextPageBg = storyViewModel.getPageBackground(scrollPosition! + 1, episode: episodeViewModel.selectedEpisode!)

        peelBackground = AnyView(Image(nextPageBg ?? storyViewModel.storyPage!.background)
            .resizable()
            .scaledToFill()
            .frame(width: Screen.width, height: Screen.height, alignment: .center)
            .clipped())
        peelEffectState = .start
        toBeExecutedByPeelEffect = {
            self.scrollPosition! += 1
            self.peelEffectState = .stop

            self.onPageChange()
        }
    }

    func prevPage(_ targetScrollPosition: Int? = nil) {
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
            self.peelEffectState = .stop
            self.isReversePeel = false
        }

        onPageChange()
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

    func onPressSoundButton() {
        if !isMuted {
            audioViewModel.mute()
        } else {
            audioViewModel.unmute()
        }
        isMuted.toggle()
    }

    func exit() {
        navigate.pop {
            self.stop()
        }
    }

    func continueStory() {
        episodeViewModel.setToAvailable(selectedStoryTheme: storyThemeViewModel.selectedStoryTheme!)
        userViewModel.addingAvailableEpisode()
        storyThemeViewModel.fetchStoryThemes()
        storyThemeViewModel.setSelectedStoryTheme(storyThemeViewModel.findWithID(storyThemeViewModel.selectedStoryTheme!.uid)!)
        navigate.pop {
            self.stop()
        }
    }

    func onAppear() {
        onPageChange()
        mazePromptViewModel.reset(true)
    }
}
