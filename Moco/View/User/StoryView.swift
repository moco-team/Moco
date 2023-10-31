//
//  StoryView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 15/10/23.
//

import SwiftUI

struct Narrative: Hashable {
    var text: String

    /// Duration in seconds

    var duration: Double // MARK: - In seconds

    /// Position in percentage of the size of the screen

    var positionX: Double // MARK: - position in percentage of the size of the screen

    var positionY: Double
    var maxWidth: Double? = Screen.width * 0.5
    var color: Color? = .black
}

struct Prompt: Hashable {
    var type: PromptType
    var startTime: Double
}

struct LottieAsset: Hashable {
    var fileName: String = ""

    /// Position in percentage of the size of the screen

    var positionX: Double // MARK: - position in percentage of the size of the screen

    var positionY: Double
    var maxWidth: Double? = Screen.width * 0.52
}

struct StoryView: View {
    // MARK: - Environments stored property

    @Environment(\.episodeViewModel) private var episodeViewModel

    @Environment(\.timerViewModel) private var timerViewModel
    @Environment(\.audioViewModel) private var audioViewModel
    @Environment(\.navigate) private var navigate
    @EnvironmentObject var speechViewModel: SpeechRecognizerViewModel
    @EnvironmentObject var objectDetectionViewModel: ObjectDetectionViewModel

    // MARK: - Static Variables

    private static let storyVolume: Float = 0.5

    // MARK: - States

    @State private var scrollPosition: Int? = 0
    @State private var isPopUpActive = false
    @State private var isMuted = false
    @State private var text: String = ""
    @State private var narrativeIndex: Int = -1
    @State private var lottieAnimationIndex: Int = -1
    @State private var showPromptButton = false
    @State private var activePrompt: Prompt?

    // MARK: - Variables

    var title: String? = "Hello World"

    var storyBackgrounds: [String] = []

    var narratives: [[Narrative]] = []

    var lottieAnimations: [LottieAsset?] = []

    var prompts: [Prompt?] = []

    var bgSounds: [String] = []

    // MARK: - Functions

    private func updateText() {
        guard narratives[scrollPosition!].indices.contains(narrativeIndex + 1) else { return }
        narrativeIndex += 1
        speechViewModel.textToSpeech(text: narratives[scrollPosition!][narrativeIndex].text)
        timerViewModel.setTimer(key: "storyPageTimer-\(narrativeIndex)-\(scrollPosition!)", withInterval: narratives[scrollPosition!][narrativeIndex].duration) {
            updateText()
        }
    }

    private func stop() {
        timerViewModel.stopTimer()
        audioViewModel.stopAllSounds()
        speechViewModel.stopSpeaking()
    }

    private func startNarrative() {
        guard narratives.indices.contains(scrollPosition ?? -1) else { return }
        narrativeIndex = -1
        updateText()
    }

    private func startPrompt() {
        showPromptButton = false
        activePrompt = nil
        guard prompts.indices.contains(scrollPosition ?? -1) && prompts[scrollPosition!] != nil else { return }
        timerViewModel.setTimer(key: "storyPagePrompt-\(scrollPosition!)", withInterval: prompts[scrollPosition!]!.startTime) {
            withAnimation {
                showPromptButton = true
            }
        }
    }

    private func onPageChange() {
        stop()
        if bgSounds.indices.contains(scrollPosition ?? -1) {
            audioViewModel.playSound(
                soundFileName: bgSounds[scrollPosition ?? 0],
                numberOfLoops: -1,
                volume: StoryView.storyVolume
            )
        }
        if lottieAnimationIndex < lottieAnimations.count {
            lottieAnimationIndex += 1
        }
        startNarrative()
        startPrompt()
    }

    private func nextPage() {
        guard storyBackgrounds.count > scrollPosition! + 1 else {
            episodeViewModel.appendEpisodeActive(1)
            isPopUpActive = true
            return
        }
        withAnimation {
            scrollPosition! += 1
        }
    }

    // MARK: - View

    var body: some View {
        ZStack {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(Array(storyBackgrounds.enumerated()), id: \.offset) { index, background in
                        ZStack {
                            Image(background)
                                .resizable()
                                .scaledToFill()
                                .frame(width: Screen.width, height: Screen.height, alignment: .center)
                                .clipped()

                            if let lottie = lottieAnimations[scrollPosition!] {
                                LottieView(fileName: lottie.fileName)
                                    .frame(maxWidth: CGFloat(lottie.maxWidth!))
                                    .position(CGPoint(
                                        x: lottie.positionX,
                                        y: lottie.positionY
                                    ))
                                    .id(lottieAnimationIndex)
                            }
                            if narratives[scrollPosition!].count > narrativeIndex && !narratives[scrollPosition!].isEmpty {
                                Text(narratives[scrollPosition!][max(narrativeIndex, 0)].text)
                                    .foregroundColor(narratives[scrollPosition!][max(narrativeIndex, 0)].color!)
                                    .frame(maxWidth: CGFloat(narratives[scrollPosition!][max(narrativeIndex, 0)].maxWidth!), alignment: .leading)
                                    .position(CGPoint(
                                        x: Screen.width * narratives[scrollPosition!][max(narrativeIndex, 0)].positionX,
                                        y: Screen.height * narratives[scrollPosition!][max(narrativeIndex, 0)].positionY
                                    ))
                                    .id(narrativeIndex)
                                    .transition(.opacity.animation(.linear))
                                    .customFont(.didactGothic, size: 30)
                                    .padding(.bottom, 2)
                            }

                            Group {
                                switch activePrompt?.type {
                                case .puzzle:
                                    FindTheObjectView(
                                        isPromptDone: .constant(false),
                                        content: "Once upon a time...",
                                        hints: ["Coba lagi!", "Ayo coba lagi!"],
                                        correctAnswer: "Jawaban yang benar adalah balon berwarna Merah",
                                        balloons: [
                                            Balloon(color: "orange", isCorrect: false),
                                            Balloon(color: "ungu", isCorrect: false),
                                            Balloon(color: "merah", isCorrect: true),
                                            Balloon(color: "hijau", isCorrect: false),
                                            Balloon(color: "biru", isCorrect: false)
                                        ]
                                    ) {
                                        nextPage()
                                    }
                                case .findHoney:
                                    FindHoney(isPromptDone: .constant(false)) {
                                        nextPage()
                                    }
                                case .objectDetection:
                                    DetectionView {
                                        nextPage()
                                    }
                                case .speech:
                                    SpeakTheStory {
                                        nextPage()
                                    }
                                default:
                                    EmptyView()
                                }
                            }
                        }.id(index)
                    }
                }.scrollTargetLayout()
            }.scrollDisabled(true)
                .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
                .scrollPosition(id: $scrollPosition)
            ZStack {
                VStack {
                    HStack {
                        Spacer()
                        Button {
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
                        Button {
                            isPopUpActive = true
                        } label: {
                            Image("Buttons/button-x").resizable().scaledToFit()
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
                            guard scrollPosition! > 0 else { return }
                            withAnimation {
                                scrollPosition! -= 1
                            }
                        }
                    }
                    Spacer()
                    if prompts.indices.contains(scrollPosition ?? -1) &&
                        prompts[scrollPosition!] == nil {
                        StoryNavigationButton(direction: .right) {
                            nextPage()
                        }
                    }
                }
                VStack {
                    Spacer()
                    if showPromptButton {
                        Button {
                            activePrompt = prompts[scrollPosition!]
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
        .popUp(isActive: $isPopUpActive, title: "Are you sure you want to quit?", cancelText: "No") {
            navigate.pop()
        }
        .task {
            onPageChange()
        }
        .onDisappear {
            stop()
        }
        .onChange(of: scrollPosition) {
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
