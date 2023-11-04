//
//  ARClueView.swift
//  Moco
//
//  Created by Carissa Farry Hilmi Az Zahra on 28/10/23.
//

import SwiftUI

struct ARClueView: View {
    @State var fadeInGameStartView = false
    @State private var tutorialVisibility: Bool = false
    @State private var isButtonVisible = false

    @State var tabs: [Gesture] = gestureList
    @State var currentIndex: Int = 0

    @State var fadeInTutorialView = false

    var clue: String

    var onStartGame: () -> Void = {}

    var body: some View {
        ZStack {
            VStack {
                Spacer()

                Text(clue)
                    .customFont(.cherryBomb, size: 30)
                    .foregroundColor(.blue2Txt)
                    .glowBorder(color: .white, lineWidth: 5)
                    .padding(.top, 10)
                    .padding(.bottom, 40)
                    .padding(.horizontal, 80)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)

                TutorialView(tabs: $tabs, currentIndex: $currentIndex, onClose: {
                    tutorialVisibility = false
                })
                .onAppear {
                    withAnimation(.easeIn(duration: 0.6)) {
                        fadeInTutorialView.toggle()
                    }
                }.opacity(fadeInTutorialView ? 1 : 0)

                Spacer()

                if isButtonVisible {
                    Button {
                        onStartGame()
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
                    .transition(.opacity)
                    .padding(.bottom, 20)
                }
                Spacer()
            }
        }
        .background(
            Image("Story/Content/Story1/Ep3/background")
            .resizable()
            .ignoresSafeArea()
            .frame(width: Screen.width, height: Screen.height)
        )
        .task {
            withAnimation(Animation.easeIn(duration: 1.5)) {
                fadeInGameStartView.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation {
                    isButtonVisible = true
                }
            }
        }
        .opacity(fadeInGameStartView ? 1 : 0)
    }
}

#Preview {
    ARClueView(
        clue: "Wow! kita sudah berada di pulau Arjuna. Sekarang, kita perlu mencari benda yang dapat menjadi clue untuk menemukan Maudi!",
        onStartGame: {}
    )
}
