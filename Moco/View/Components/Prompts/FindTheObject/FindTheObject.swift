//
//  SwiftUIView.swift
//  Moco
//
//  Created by Carissa Farry Hilmi Az Zahra on 17/10/23.
//

import SwiftUI

struct Balloon {
    let color: String
    let isCorrect: Bool
}


struct FindTheObjectView: View {
    @Environment(\.navigate) private var navigate
    
    @Binding var isPromptDone: Bool
    
    let content: String
    let balloons: [Balloon]
    
    @State private var isPromptVisible = false
    @State private var isCorrectObjectTapped = false
    
    var body: some View {
        VStack {
            ForEach(balloons, id: \.color) { balloon in
                Button(action: {
                    handleObjectTap(balloon: balloon)
                }) {
                    Text(balloon.color)
                        .font(.subheadline)
                        .padding()
                        .background(balloon.isCorrect ? Color.green : Color.blue)
                        .cornerRadius(10)
                        .foregroundColor(.white)
                    
                    Image("Story/Content/Story1/Pages/Page1/balon-\(balloon.color)").resizable().frame(width: 22, height: 22)
                }
            }
        }
        .popUp(isActive: $isCorrectObjectTapped, title: "Selamat kamu suda menemukan balon yang Moco cari! \n Lanjutkan cerita?") {
            isPromptDone = true
            print(isPromptDone)
        }
        
        // Prompt to find the correct object
        if isPromptVisible {
            Text(isCorrectObjectTapped ? "Correct!" : "Try again.")
                .font(.headline)
                .foregroundColor(isCorrectObjectTapped ? .green : .red)
        }
    }
    
    func handleObjectTap(balloon: Balloon) {
        if balloon.isCorrect {
            isCorrectObjectTapped = true
        } else {
            isCorrectObjectTapped = false
        }
        isPromptVisible = true
    }
}

#Preview {
    FindTheObjectView(
        isPromptDone: .constant(false),
        content: "Once upon a time...",
        balloons: [
            Balloon(color: "orange", isCorrect: false),
            Balloon(color: "ungu", isCorrect: true),
            Balloon(color: "merah", isCorrect: false),
            Balloon(color: "hijau", isCorrect: false),
            Balloon(color: "biru", isCorrect: false)
        ]
    )
}
