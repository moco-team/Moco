//
//  StoryView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 15/10/23.
//

import SwiftUI

struct Narrative {
    var text: String

    /// Duration in seconds

    var duration: Double // MARK: - In seconds

    /// Position in percentage of the size of the screen

    var positionX: Double // MARK: - position in percentage of the size of the screen

    var positionY: Double
    var maxWidth: Double? = Screen.width * 0.5
    var color: Color? = .black
}

struct Prompt {
    var type: PromptType
    var startTime: Double
}

struct LottieAsset {
    var fileName: String

    /// Position in percentage of the size of the screen

    var positionX: Double // MARK: - position in percentage of the size of the screen

    var positionY: Double
    var maxWidth: Double? = Screen.width * 0.52
}

struct StoryView: View {
    // MARK: - Environments stored property

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
            .init(text: "Moco si Sapi adalah seekor sapi yang cerdik. \nDia ingin menjelajahi dunia.", duration: 2.5, positionX: 0.31, positionY: 0.15)
        ],
        [
            .init(text: "Di perjalanannya, dia bertemu dengan teman-temannya yang membutuhkan bantuan.", duration: 5, positionX: 0.31, positionY: 0.18, maxWidth: Screen.width * 0.4)
        ],
        [
            .init(text: "Saat menjelajahi hutan rimba, ", duration: 4, positionX: 0.3, positionY: 0.17, maxWidth: Screen.width * 0.4),
            .init(text: "dia bertemu Maudi si Beruang madu yang sedang menangis.", duration: 5, positionX: 0.3, positionY: 0.17, maxWidth: Screen.width * 0.4),
            .init(text: "Mari kita tanya mengapa Maudi menangis.", duration: 4, positionX: 0.3, positionY: 0.13, maxWidth: Screen.width * 0.4),
            .init(text: "Apa yang sedang dilakukan Maudi?", duration: 2, positionX: 0.3, positionY: 0.13, maxWidth: Screen.width * 0.4)
        ],
        [
            .init(text: "Ternyata Maudi kehilangan madunya!", duration: 3.5, positionX: 0.5, positionY: 0.3),
            .init(text: "Yuk bantu Maudi mencari madu kesayangannya!", duration: 3.5, positionX: 0.5, positionY: 0.3)
        ],
        [
            .init(text: "Moco melanjutkan petualangannya. \nSaat ingin melewati gua, dia bertemu dengan Teka & Teki si Tikus.", duration: 5, positionX: 0.71, positionY: 0.85)
        ],
        [
            .init(text: "Teka & Teki melarang Moco untuk melewati gua sebelum dia menjawab teka teki yang mereka berikan.", duration: 9, positionX: 0.5, positionY: 0.15),
            .init(text: "Yuk kita selesaikan teka-tekinya!", duration: 2, positionX: 0.5, positionY: 0.15)
        ],
        [
            .init(text: "Aku berkaki empat, tetapi aku tidak bisa berjalan. Orang-orang biasanya duduk di atasku.\nSiapakah aku?", duration: 9, positionX: 0.6, positionY: 0.3)
        ],
        [
            .init(text: "Saat langit sudah mulai gelap, Moco bertemu dengan Kakak Katak yang sedang kesulitan menangkap balon.", duration: 5, positionX: 0.7, positionY: 0.15, color: .white)
        ],
        [
            .init(text: "Kakak Katak sedang mengumpulkan balon yang berwarna Merah. Yuk kita bantu Kakak Katak menangkap balon!", duration: 7, positionX: 0.6, positionY: 0.2, color: .white)
        ],
        [
            .init(text: "Matahari pun terbenam dan Moco merasa lelah. Moco memutuskan untuk beristirahat dan melanjutkan petualangannya esok hari.", duration: 12, positionX: 0.67, positionY: 0.63),
            .init(text: "Hari ini, Moco belajar bahwa petualangan bisa menjadi kesempatan untuk membantu teman-temannya.", duration: 9, positionX: 0.67, positionY: 0.63),
            .init(text: "Moco tidur dengan senyum di wajahnya, bermimpi tentang petualangan berikutnya.", duration: 5, positionX: 0.67, positionY: 0.63)
        ]
    ]

    private let lottieAnimations: [LottieAsset?] = [
        .init(fileName: "moco-1-1", positionX: Screen.width * 0.65, positionY: Screen.height * 0.6),
        .init(fileName: "moco-1-2", positionX: Screen.width * 0.54, positionY: Screen.height * 0.6, maxWidth: Screen.width * 0.15),
        .init(fileName: "maudi", positionX: Screen.width * 0.6, positionY: Screen.height * 0.6),
        nil,
        .init(fileName: "moco-1-5", positionX: Screen.width * 0.25, positionY: Screen.height * 0.58, maxWidth: Screen.width * 0.39),
        .init(fileName: "teka_dan_teki", positionX: Screen.width * 0.5, positionY: Screen.height * 0.72, maxWidth: Screen.width * 0.9),
        nil,
        .init(fileName: "kakak_katak", positionX: Screen.width * 0.54, positionY: Screen.height * 0.678, maxWidth: Screen.width * 0.35),
        nil,
        .init(fileName: "moco-1-10", positionX: Screen.width * 0.22, positionY: Screen.height * 0.75, maxWidth: Screen.width * 0.35)
    ]

    private let prompts: [Prompt?] = [
        nil,
        nil,
        .init(type: .speech, startTime: 3),
        .init(type: .findHoney, startTime: 3),
        nil,
        nil,
        .init(type: .objectDetection, startTime: 3),
        nil,
        .init(type: .puzzle, startTime: 3),
        nil
    ]

    private let bgSounds = ["bg-story", "bg-story", "bg-story", "bg-story", "bg-story", "bg-story", "bg-story", "bg-story", "bg-story", "bg-story"]

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
