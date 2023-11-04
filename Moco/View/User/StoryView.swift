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

    @Environment(\.timerViewModel) private var timerViewModel
    @Environment(\.audioViewModel) private var audioViewModel
    @Environment(\.navigate) private var navigate
    @EnvironmentObject var speechViewModel: SpeechRecognizerViewModel
    @EnvironmentObject var objectDetectionViewModel: ObjectDetectionViewModel

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
    var enableUI = true

    // MARK: - Variables

    /*
     CERITA + PERTANYAAN

     1. Tahap pengenalan
     Moco, Bebe, Teka, dan Teki merupakan sahabat karib yang tinggal di Kota Mocokerto. Moco merupakan seekor anak sapi yang lucu. Bebe adalah seekor anak beruang yang polos. Sedangkan, si kembar teka-teki merupakan dua anak tikus yang buta. Suatu hari, mereka pergi berpetualang bersama.

     Siapakah nama seekor anak sapi yang lucu?
     A.) Moco
     B.) Bebe
     C.) Teka dan Teki

     2. Tahap munculnya konflik
     Di tengah petualangan mereka, datanglah katak bernama Kato yang menawarkan madu secara gratis kepada anak-anak. Karena tertarik, Bebe langsung memasukkan tangannya ke dalam toples madu yang ditawarkan Kato. Namun, Bebe tidak dapat mengeluarkan tangannya dari toples karena toples tersebut berisi lem dan bukan madu. Kato pun membawa kabur Bebe dan menculik Bebe yang polos.

     Mengapa Bebe tidak dapat mengeluarkan tangannya dari toples?
     A. Karena tangan Bebe terlalu besar
     B. Karena Kato merupakan katak yang jahat
     C. Karena toples tersebut berisi lem yang lengket

     3. Tahap peningkatan masalah
     Moco, Teka, dan Teki berusaha mengejar Kato dan Bebe. Akan tetapi, Kato membawa Bebe ke pulau Arjuna dengan cara melompat di atas air. Perjalanan mengejar Kato dan Bebe pun terpaksa berhenti.

     Mengapa perjalanan mengejar Kato dan Bebe terpaksa berhenti?
     A. Karena Moco, Teka, dan Teki capek bermain kejar-kejaran
     B. Karena Kato dan Bebe sudah tidak asik untuk diajak bermain
     C. Karena Moco, Teka, dan Teki merupakan hewan darat

     4. Tahap klimaks
     Moco menoleh ke kanan dan kiri, namun mendapati bahwa Teka dan Teki tidak ada di sekitarnya. Seketika, Moco baru sadar kalau ia telah berlari sendirian karena si kembar Teka dan Teki tidak bisa melihat. Sekarang, Moco telah kehilangan seluruh teman berpetualangnya.

     Bagaimana perasaan Moco ketika ia kehilangan seluruh teman berpetualangnya?
     A. Moco merasa senang
     B. Moco merasa sedih
     C. Moco merasa lapar

     5. Tahap antiklimaks
     Moco teringat cerita Teka dan Teki bahwa mereka merasa nyaman bersembunyi di dalam terowongan. Moco pun berangkat mencari Teka dan Teki menuju ke terowongan.
     [MODAL LANJUT / NANTI]

     ———

     [maze/gyroscape]

     “Berapakah jumlah teman yang sedang Moco cari di dalam terowongan?”
     A.) 1
     B.) 2
     C.) 3

     “Benda apakah yang digunakan oleh Teka dan Teki?”
     A.) Tongkat
     B.) Tas Ransel
     C.) Kacamata Hitam

     “Hewan apakah yang sedang Moco cari di dalam terowongan?”
     A.) Tikus
     B.) Sapi
     C.) Katak

     Hore! Moco berhasil menemukan Teka dan Teki. Mereka bertiga segera keluar dari terowongan. Siapa sangka, setelah keluar dari terowongan mereka menemukan jembatan menuju ke pulau Arjuna. Mereka bertiga pun berjalan melewati jembatan untuk mencari Bebe di pulau Arjuna.

     ———

     3D/AR World

     (i) Wow! kita sudah berada di pulau Arjuna. Sekarang, kita perlu mencari benda yang dapat menjadi clue untuk menemukan Maudi! —> cari honey jar

     (ii) Bagus! Kita telah menemukan dimana Bebe dikurung! Namun, pintunya terkunci. Mari kita cari sesuatu yang dapat membuka tempat Bebe dikurung —> item nya kunci

     (iii) Yeay!! Kita berhasil menemukan Bebe! Betapa melelahkannya perjalanan hari ini. Waktunya kita pulang, yuk mencari alat yang dapat membawa kita kembali ke Kota Mocokerto —> pesawat

     6. Tahap penyelesaian
     Akhirnya, Moco dan teman-teman berhasil pulang ke Kota Mocokerto setelah petualangan yang panjang. Terima kasih untuk hari ini!
     [modal selesai]
     */

    //    var firstPrompt: PromptModel? = nil
    //
    //    var multipleChoiceQnA: [MultipleChoicePromptQnA?] = [
    //        .init(
    //            correctAnswerIndex: 0,
    //            question: """
    //            Siapakah nama seekor anak sapi yang lucu?
    //            A.) Moco
    //            B.) Bebe
    //            C.) Teka dan Teki
    //            """
    //        ),
    //        .init(
    //            correctAnswerIndex: 2,
    //            question: """
    //            Mengapa Bebe tidak dapat mengeluarkan tangannya dari toples?
    //            A. Karena tangan Bebe terlalu besar
    //            B. Karena Kato merupakan katak yang jahat
    //            C. Karena toples tersebut berisi lem yang lengket
    //            """
    //        ),
    //        .init(
    //            correctAnswerIndex: 2,
    //            question: """
    //            Mengapa perjalanan mengejar Kato dan Bebe terpaksa berhenti?
    //            A. Karena Moco, Teka, dan Teki capek bermain kejar-kejaran
    //            B. Karena Kato dan Bebe sudah tidak asik untuk diajak bermain
    //            C. Karena Moco, Teka, dan Teki merupakan hewan darat
    //            """
    //        ),
    //        .init(
    //            correctAnswerIndex: 1,
    //            question: """
    //            Bagaimana perasaan Moco ketika ia kehilangan seluruh teman berpetualangnya?
    //            A. Moco merasa senang
    //            B. Moco merasa sedih
    //            C. Moco merasa lapar
    //            """
    //        ),
    //        nil
    //    ]
    //
    //    let mazeAnswers: [MazePuzzle] = [
    //        .init(correctAnswerAsset: "Maze/answer_one", answersAsset: ["Maze/answer_two", "Maze/answer_three"], question:
    // """
    // “Berapakah jumlah teman yang sedang Moco cari di dalam terowongan?”
    // A.) 1
    // B.) 2
    // C.) 3
    // """
    //             ),
    //        .init(correctAnswerAsset: "Maze/answer_one", answersAsset: ["Maze/answer_two", "Maze/answer_three"], question:
    // """
    // “Benda apakah yang digunakan oleh Teka dan Teki?”
    // A.) Tongkat
    // B.) Tas Ransel
    // C.) Kacamata Hitam
    // """
    //             ),
    //        .init(correctAnswerAsset: "Maze/answer_one", answersAsset: ["Maze/answer_two", "Maze/answer_three"], question:
    // """
    // “Hewan apakah yang sedang Moco cari di dalam terowongan?”
    // A.) Tikus
    // B.) Sapi
    // C.) Katak
    // """
    //             )
    //    ]

    // MARK: - Functions

    private func updateText() {
        guard storyContentViewModel.narratives!.indices.contains(narrativeIndex + 1) else { return }
        narrativeIndex += 1
        speechViewModel.textToSpeech(text: storyContentViewModel.narratives![narrativeIndex].contentName)
        timerViewModel.setTimer(key: "storyPageTimer-\(narrativeIndex)-\(scrollPosition!)", withInterval: storyContentViewModel.narratives![narrativeIndex].duration) {
            updateText()
        }
    }

    private func stop() {
        timerViewModel.stopTimer()
        audioViewModel.stopAllSounds()
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
        guard promptViewModel.prompt != nil else { return }
        timerViewModel.setTimer(key: "storyPagePrompt-\(scrollPosition!)", withInterval: promptViewModel.prompt!.startTime) {
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
        startPrompt()
        if let storyPage = storyViewModel.storyPage, storyPage.earlyPrompt {
            promptViewModel.fetchPrompt(storyPage)
            activePrompt = promptViewModel.prompt!
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

    private func prevPage() {
        guard scrollPosition! > 0 else { return }
        isReversePeel = true
        scrollPosition! -= 1
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

                promptViewModel.fetchPrompt(storyPage)

                if let prompt = promptViewModel.prompt, prompt.hints != nil {
                    hintViewModel.fetchHints(prompt)
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
                            PeelEffectTappable(state: $peelEffectState, isReverse: isReversePeel) {
                                ZStack {
                                    Image(storyViewModel.storyPage!.background)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: Screen.width, height: Screen.height, alignment: .center)
                                        .clipped()

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

                                    Group {
                                        switch activePrompt?.promptType {
                                        case .multipleChoice:
                                            if promptViewModel.prompt != nil {
                                                MultipleChoicePrompt {
                                                    activePrompt = nil
                                                    nextPage()
                                                } onWrong: {
                                                    showWrongAnsPopup = true
                                                }
                                            }
                                        case .maze:
                                            if let mazePrompt = promptViewModel.prompt {
                                                MazePrompt(promptText: mazePrompt.question!, answersAsset: mazePrompt.answerChoices!, correctAnswerAsset: mazePrompt.correctAnswer) {
                                                    nextPage()
                                                }.id(mazePrompt.id)
                                            }
                                        case .ar:
                                            ARStory() {
                                                nextPage()
                                            }
                                        case .puzzle:
                                            FindTheObjectView(
                                                isPromptDone: .constant(false),
                                                content: "Once upon a time...",
                                                hints: hintViewModel.hints,
                                                correctAnswer: promptViewModel.prompt!.correctAnswer,
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
                                        case .objectDetection:
                                            DetectionView {
                                                nextPage()
                                            }
                                        default:
                                            EmptyView()
                                        }
                                    }

                                }.id(index)
                            } background: {
                                peelBackground
                            } onComplete: {
                                toBeExecutedByPeelEffect()
                            }
                        }
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
                            isExitPopUpActive = true
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
                            prevPage()
                        }
                    }
                    Spacer()

                    if promptViewModel.prompt == nil || forceShowNext {
                        StoryNavigationButton(direction: .right) {
                            nextPage()
                        }
                    }
                }
                VStack {
                    Spacer()
                    if showPromptButton && activePrompt == nil {
                        Button {
                            activePrompt = promptViewModel.prompt!
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
            navigate.pop()
        }
        .popUp(isActive: $isEpisodeFinished, title: "Petualangan Moco sebentar lagi selesai!. Lanjutkan petualangan?", cancelText: "Tidak", confirmText: "Lanjut") {
            episodeViewModel.setToAvailable(selectedStoryTheme: storyThemeViewModel.selectedStoryTheme!)
            storyThemeViewModel.fetchStoryThemes()
            storyThemeViewModel.setSelectedStoryTheme(storyThemeViewModel.findWithID(storyThemeViewModel.selectedStoryTheme!.uid)!)
            navigate.pop()
        }
        .customModal(isActive: $showWrongAnsPopup, title: "Apakah kamu yakin dengan jawaban ini? Coba cek kembali pertanyaannya") {
            activePrompt = nil
            showWrongAnsPopup = false
        }
        .task {
            onPageChange()
        }
        .onDisappear {
            stop()
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
