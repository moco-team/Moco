//
//  MakeSentence.swift
//  Moco
//
//  Created by Carissa Farry Hilmi Az Zahra on 18/11/23.
//

import SwiftUI

struct MakeSentence: View {
    @Environment(\.audioViewModel) private var audioViewModel
    @Environment(\.navigate) private var navigate

    @State private var currentPromptIndex = 0
    @State private var showWrongAnswerPopup = false

    @State var fadeMakeSentenceView = false
    @State var showTutorial = true
    @State var showStartButton = false
    @State var showPromptModal = false

    @State private var scanResult: [String] = []
    @State private var showScanner = false
    @State private var showFinishPopUp = false

    var onComplete: (() -> Void)?

    var prompts: [PromptModel] = [
        .init(
            correctAnswer: "bebe",
            startTime: 0,
            promptType: PromptType.card,
            hints: nil,
            question: "Siapa yang sedang lapar?",
            imageCard: "Story/Content/Story1/Pages/Page1/bebe-card" // TODO: Add image card
        ),
        .init(
            correctAnswer: "makan",
            startTime: 0,
            promptType: PromptType.card,
            hints: nil,
            question: "Apa yang akan dilakukan Bebe selanjutnya?",
            imageCard: "" // TODO: Add image card
        ),
        .init(
            correctAnswer: "madu",
            startTime: 0,
            promptType: PromptType.card,
            hints: nil,
            question: "Apa yang bebe makan?",
            imageCard: "" // TODO: Add image card
        )
    ]

    var promptSound: [String] = [
        "Cari kartu karakter",
        "Cari kartu kata kerja",
        "Cari kartu benda"
    ]

    var body: some View {
        ZStack {
            // TODO: Modal: Susunlah 1 kartu biru, 1 kartu ungu, dan 1 kartu merah menjadi sebuah kalimat
            if showTutorial {
                // TODO: Illustrasi: susun kartu (karakter + kt kerja + kt benda) menjadi kalimat
//                ZStack {
//                    Color.black.opacity(0.2)
//                    Image("AR/Tutorial/plane")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: Screen.width * 0.3, height: Screen.height * 0.3)
//
//                    VStack {
//                        GIFView(type: .name("find-ar-plane"))
//                            .frame(width: 200, height: 200)
//                            .padding(.horizontal)
//                            .padding(.top, -75)
//                            .frame(width: 280, alignment: .center)
//
//                        Text("Cari area datar")
//                            .customFont(.didactGothic, size: 30)
//                            .foregroundColor(.white)
//                            .padding()
//                    }
//                }
            } else {
                if showScanner {
                    CardScan(scanResult: $scanResult) {
                        showScanner = false

                        scanResult = scanResult.map {
                            $0.fromBase64() ?? ""
                        }

                        if scanResult.joined(separator: " ")
                            .trimmingCharacters(in: .whitespacesAndNewlines) != prompts[currentPromptIndex].correctAnswer {
                            showWrongAnswerPopup = true
                            return
                        }

                        currentPromptIndex += 1
                        print("currentPromptIndex")
                        print(currentPromptIndex)
                        if currentPromptIndex >= prompts.count {
                            currentPromptIndex -= 1 // error prevention
                            showFinishPopUp = true
                            showPromptModal = false
                        } else {
                            showPromptModal = true
                        }
                    }
                }
            }
        }
        .onAppear {
            currentPromptIndex = 0

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                // TODO: Gada suara
                audioViewModel.playSoundsQueue(
                    sounds: [
                        .init(fileName: "Apa yang akan dilakukan bebe selanjutnya", type: "m4a"),
                        .init(fileName: "Susunlah sebuah kalimat", type: "m4a")
                    ],
                    intervalDuration: 3
                )
            }
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                withAnimation {
                    showStartButton = true
                }
            }
        }
        .onChange(of: showTutorial) { _, _ in
            if showTutorial == true {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    withAnimation {
                        showPromptModal = true
                    }
                }
            }
        }
        .onChange(of: showPromptModal) { _, _ in
            if showPromptModal == true {
                audioViewModel.playSound(soundFileName: promptSound[currentPromptIndex], type: .m4a, category: .narration)
            }
        }
        .popUp(
            isActive: $showPromptModal,
            title: prompts[currentPromptIndex].question!,
            confirmText: "Scan",
            closeWhenDone: true,
            shakeItOff: 1
        ) {
            showTutorial = false
            showScanner = true
        } cancelHandler: {
            showScanner = true
        }
        .popUp(
            isActive: $showStartButton,
            title: "Setelah perjalanan yang panjang, Bebe sangat lelah dan lapar. Bantulah Bebe mencari sesuatu yang dapat dimakan!",
            confirmText: "Scan",
            disableCancel: true,
            shakeItOff: 1
        ) {
            showStartButton = false
            showPromptModal = true
        }
        .popUp(
            isActive: $showWrongAnswerPopup,
            title: "Belum tepat!\n" + prompts[currentPromptIndex].question!,
            confirmText: "Scan",
            closeWhenDone: true,
            shakeItOff: 1,
            type: .danger
        ) {
            showWrongAnswerPopup = false
            showScanner = true
        } cancelHandler: {
            showScanner = true
        }
        .popUp(isActive: $showFinishPopUp, title: "Selamat kamu berhasil menyusun kalimat!", withConfetti: true, closeWhenDone: true, disableCancel: true) {
            showFinishPopUp = false
            print("selesai cak")
            onComplete?()

        } cancelHandler: {
            showFinishPopUp = true
        }
    }
}

#Preview {
    MakeSentence()
}
