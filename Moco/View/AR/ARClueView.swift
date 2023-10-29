//
//  ARClueView.swift
//  Moco
//
//  Created by Carissa Farry Hilmi Az Zahra on 28/10/23.
//

import SwiftUI

struct ARClueView: View {
    @State var fadeInGameStartView = false
    
    var clue: String
    
    var onStartGame: () -> () = {}
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: Screen.width, height: Screen.height)
                .edgesIgnoringSafeArea(.all)
                .foregroundColor(Color.bgPrimary)
            
            VStack {
                Text(clue)
                    .foregroundStyle(.brownTxt)
                
                Button(action: {
                    onStartGame()
                }, label: {
                    Text("Mulai")
                })
                .buttonStyle(CircleButton(width: 80, height: 80))
                .padding()
            }
        }
        .onAppear() {
            withAnimation(Animation.easeIn(duration: 1.5)){
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
