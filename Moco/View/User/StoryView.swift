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
    var fontSize: CGFloat = 30
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
    @State private var peelEffectState = PeelEffectState.stop
    @State private var toBeExecutedByPeelEffect = {}
    @State private var peelBackground = AnyView(EmptyView())
    @State private var isReversePeel = false
    @State private var showWrongAnsPopup = false
    @State private var mazeQuestionIndex = 0
    @State private var forceShowNext = false

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

    var title: String? = "Hello World"

    var storyBackgrounds: [String] = []

    var narratives: [[Narrative]] = []

    var lottieAnimations: [LottieAsset?] = []

    var prompts: [Prompt?] = []

    var bgSounds: [String] = []

    var firstPrompt: Prompt?

    var multipleChoiceQnA: [MultipleChoicePromptQnA?] = [
        .init(
            correctAnswerIndex: 0,
            question: """
            Siapakah nama seekor anak sapi yang lucu?
            A.) Moco
            B.) Bebe
            C.) Teka dan Teki
            """
        ),
        .init(
            correctAnswerIndex: 2,
            question: """
            Mengapa Bebe tidak dapat mengeluarkan tangannya dari toples?
            A. Karena tangan Bebe terlalu besar
            B. Karena Kato merupakan katak yang jahat
            C. Karena toples tersebut berisi lem yang lengket
            """
        ),
        .init(
            correctAnswerIndex: 2,
            question: """
            Mengapa perjalanan mengejar Kato dan Bebe terpaksa berhenti?
            A. Karena Moco, Teka, dan Teki capek bermain kejar-kejaran
            B. Karena Kato dan Bebe sudah tidak asik untuk diajak bermain
            C. Karena Moco, Teka, dan Teki merupakan hewan darat
            """
        ),
        .init(
            correctAnswerIndex: 1,
            question: """
            Bagaimana perasaan Moco ketika ia kehilangan seluruh teman berpetualangnya?
            A. Moco merasa senang
            B. Moco merasa sedih
            C. Moco merasa lapar
            """
        ),
        nil
    ]

    let mazeAnswers: [MazePuzzle] = [
        .init(correctAnswerAsset: "Maze/answer_three", answersAsset: ["Maze/answer_two", "Maze/answer_one"], question:
            """
            “Berapakah jumlah teman yang sedang Moco cari di dalam terowongan?”
            A.) 1
            B.) 2
            C.) 3
            """),
        .init(correctAnswerAsset: "Maze/answer_glass", answersAsset: ["Maze/answer_hammer", "Maze/answer_backpack"], question:
            """
            “Benda apakah yang digunakan oleh Teka dan Teki?”
            A.) Tongkat
            B.) Tas Ransel
            C.) Kacamata Hitam
            """),
        .init(correctAnswerAsset: "Maze/answer_mice", answersAsset: ["Maze/answer_sapi_jantan", "Maze/answer_frog"], question:
            """
            “Hewan apakah yang sedang Moco cari di dalam terowongan?”
            A.) Tikus
            B.) Sapi
            C.) Katak
            """)
    ]

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
                category: .backsound
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
        peelBackground = AnyView(Image(storyBackgrounds[scrollPosition! + 1])
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
        peelBackground = AnyView(Image(storyBackgrounds[scrollPosition! + 1])
            .resizable()
            .scaledToFill()
            .frame(width: Screen.width, height: Screen.height, alignment: .center)
            .clipped())
        toBeExecutedByPeelEffect = {
            peelEffectState = .stop
            isReversePeel = false
        }
    }

    // MARK: - View

    var body: some View {
        ZStack {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(Array(storyBackgrounds.enumerated()), id: \.offset) { index, background in
                        PeelEffectTappable(state: $peelEffectState, isReverse: isReversePeel) {
                            ZStack {
                                Image(background)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: Screen.width, height: Screen.height, alignment: .center)
                                    .clipped()

                                if narratives[scrollPosition!].count > narrativeIndex && !narratives[scrollPosition!].isEmpty {
                                    let narrative = narratives[scrollPosition!][max(narrativeIndex, 0)]
                                    Text(narrative.text)
                                        .foregroundColor(narrative.color!)
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
                                    let mcPrompt = multipleChoiceQnA[scrollPosition!]
                                    let mazeQuestion = mazeAnswers[mazeQuestionIndex]
                                    switch activePrompt?.type {
                                    case .multipleChoice:
                                        if mcPrompt != nil {
                                            MultipleChoicePrompt(correctAnswerIndex: mcPrompt!.correctAnswerIndex, question: mcPrompt!.question) {
                                                activePrompt = nil
                                                nextPage()
                                            } onWrong: {
                                                showWrongAnsPopup = true
                                            }
                                        }
                                    case .maze:
                                        MazePrompt(promptText: mazeQuestion.question, answersAsset: mazeQuestion.answersAsset, correctAnswerAsset: mazeQuestion.correctAnswerAsset) {
                                            if mazeQuestionIndex < mazeAnswers.count - 1 {
                                                mazeQuestionIndex += 1
                                            } else {
                                                activePrompt = nil
                                                forceShowNext = true
                                            }
                                        }.id(mazeQuestionIndex)
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
                            prevPage()
                        }
                    }
                    Spacer()
                    if (prompts.indices.contains(scrollPosition ?? -1) &&
                        prompts[scrollPosition!] == nil) || forceShowNext {
                        StoryNavigationButton(direction: .right) {
                            nextPage()
                        }
                    }
                }
                VStack {
                    Spacer()
                    if showPromptButton && activePrompt == nil {
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
        .popUp(isActive: $isPopUpActive, title: "Yakin mau keluar?", cancelText: "No") {
            navigate.pop()
        }
        .customModal(isActive: $showWrongAnsPopup, title: "Apakah kamu yakin dengan jawaban ini? Coba cek kembali pertanyaannya") {
            activePrompt = nil
            showWrongAnsPopup = false
        }
        .task {
            onPageChange()
            if let directPrompt = firstPrompt {
                activePrompt = directPrompt
            }
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
