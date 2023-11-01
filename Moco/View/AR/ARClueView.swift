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
    @State var tabs: [Gesture] =  gestureList
    @State var currentIndex: Int = 0
    
    @State var fadeInTutorialView = false

    var clue: String

    var onStartGame: () -> Void = {}

    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: Screen.width, height: Screen.height)
                .edgesIgnoringSafeArea(.all)
                .foregroundColor(Color.bgPrimary)

            VStack {
                Text(clue)
                    .foregroundStyle(.brownTxt)
                
                TutorialView(tabs: $tabs, currentIndex: $currentIndex, onClose: {
                    tutorialVisibility = false
                })
                .onAppear() {
                    withAnimation(.easeIn(duration: 0.6)) {
                        fadeInTutorialView.toggle()
                    }
                }.opacity(fadeInTutorialView ? 1 : 0)

                Button(action: {
                    onStartGame()
                }, label: {
                    Text("Mulai")
                })
                .buttonStyle(CircleButton(width: 80, height: 80))
                .padding()
            }
        }
        .onAppear {
            withAnimation(Animation.easeIn(duration: 1.5)) {
                fadeInGameStartView.toggle()
            }
        }
        .opacity(fadeInGameStartView ? 1 : 0)
    }
}

#Preview {
    ARClueView(
        clue: "Carilah benda yang dapat menjadi clue untuk ditemukannya Beruang!",
        onStartGame: {}
    )
}
