//
//  StoryView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 15/10/23.
//

import SwiftUI

struct Narrative {
    var text: String

    var duration: Double // MARK: In seconds

    var positionX: Double // MARK: position in percentage of the size of the screen

    var positionY: Double
}

struct Prompt {
    var type: PromptType
    var startTime: Double
}

struct StoryView: View {
    // MARK: - Environments stored property

    @Environment(\.timerViewModel) private var timerViewModel
    @Environment(\.audioViewModel) private var audioViewModel
    @Environment(\.navigate) private var navigate
    @EnvironmentObject var speechViewModel: SpeechRecognizerViewModel

    // MARK: - Static Variables

    private static let storyVolume: Float = 0.5

    // MARK: - States

    @State private var scrollPosition: Int? = 0
    @State private var isPopUpActive = false
    @State private var isMuted = false
    @State private var text: String = ""
    @State private var narrativeIndex: Int = -1
    @State private var showPromptButton = false
    @State private var activePrompt: Prompt?

    // MARK: - Variables

    var title: String? = "Hello World"

    private let storyBackgrounds = [
        "Story/Content/Story1/Pages/Page1/background",
        "Story/Content/Story1/Pages/Page2/background",
        "Story/Content/Story1/Pages/Page3/background",
        "Story/Content/Story1/Pages/Page4/background",
        "Story/Content/Story1/Pages/Page5/background",
        "Story/Content/Story1/Pages/Page6/background",
        "Story/Content/Story1/Pages/Page7/background",
        "Story/Content/Story1/Pages/Page8/background",
        "Story/Content/Story1/Pages/Page9/background",
        "Story/Content/Story1/Pages/Page10/background"
    ]

    private let narratives: [[Narrative]] = [
        [
            .init(text: "Pada hari minggu", duration: 2.5, positionX: 0.6, positionY: 0.2),
            .init(text: "Moco sang sapi jantan mengangkat tangannya", duration: 3.5, positionX: 0.6, positionY: 0.2),
            .init(text: "Sambil tersenyum dia pun beranjak dari kandang sapi di tulungagung", duration: 5, positionX: 0.6, positionY: 0.2)
        ],
        [
            .init(text: "Moco pun bergegas menuju gunung bromo", duration: 3.5, positionX: 0.6, positionY: 0.2),
            .init(text: "Dia melewati lembah dan bukit", duration: 3, positionX: 0.6, positionY: 0.2),
            .init(text: "Sambil tersenyum dia pun beranjak dari kandang sapi di tulungagung", duration: 5, positionX: 0.6, positionY: 0.2)
        ],
        [
            .init(text: "Moco pun bergegas menuju gunung bromo", duration: 3.5, positionX: 0.6, positionY: 0.2),
            .init(text: "Dia melewati lembah dan bukit", duration: 3, positionX: 0.6, positionY: 0.2),
            .init(text: "Sambil tersenyum dia pun beranjak dari kandang sapi di tulungagung", duration: 5, positionX: 0.6, positionY: 0.2)
        ],
        [
            .init(text: "Moco pun bergegas menuju gunung bromo", duration: 3.5, positionX: 0.6, positionY: 0.2),
            .init(text: "Dia melewati lembah dan bukit", duration: 3, positionX: 0.6, positionY: 0.2),
            .init(text: "Sambil tersenyum dia pun beranjak dari kandang sapi di tulungagung", duration: 5, positionX: 0.6, positionY: 0.2)
        ]
    ]

    private let prompts: [Prompt?] = [
        nil,
        .init(type: .findHoney, startTime: 5),
        .init(type: .puzzle, startTime: 5),
        .init(type: .objectDetection, startTime: 5)
    ]

    private let bgSounds = ["bg-shop", "bg-story"]

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
            showPromptButton = true
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
        startNarrative()
        startPrompt()
    }
    
    private func nextPage() {
        guard storyBackgrounds.count > scrollPosition! + 1 else {
            isPopUpActive = true
            return
        }
        scrollPosition! += 1
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
                            StormView()
                            Text(narratives[scrollPosition!][max(narrativeIndex, 0)].text)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .position(CGPoint(
                                    x: Screen.width * narratives[scrollPosition!][max(narrativeIndex, 0)].positionX,
                                    y: Screen.height * narratives[scrollPosition!][max(narrativeIndex, 0)].positionY
                                ))
                                .id(narrativeIndex)
                                .transition(.opacity.animation(.linear))
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
                                    DetectionView()
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
                            Image(systemName: isMuted ? "speaker.slash" : "speaker.wave.2")
                                .resizable()
                                .scaledToFit()
                                .padding(20)
                        }.buttonStyle(CircleButton(width: 80, height: 80))
                            .padding()
                        Button {
                            isPopUpActive = true
                        } label: {
                            Image(systemName: "xmark").resizable().scaledToFit().padding(20)
                        }.buttonStyle(CircleButton(width: 80, height: 80))
                            .padding()
                    }
                    Spacer()
                }
                HStack {
                    if scrollPosition! > 0 {
                        StoryNavigationButton(direction: .left) {
                            guard scrollPosition! > 0 else { return }
                            scrollPosition! -= 1
                        }
                    }
                    Spacer()
                    StoryNavigationButton(direction: .right) {
                        nextPage()
                    }
                }
                VStack {
                    Spacer()
                    if showPromptButton {
                        Button("Start") {
                            activePrompt = prompts[scrollPosition!]
                        }.buttonStyle(CircleButton(width: 80, height: 80))
                            .padding()
                    }
                }
            }
        }
        .popUp(isActive: $isPopUpActive, title: "Are you sure you want to quit?", cancelText: "No") {
            navigate.popToRoot()
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
