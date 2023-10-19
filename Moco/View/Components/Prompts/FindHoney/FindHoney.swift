//
//  FindHoney.swift
//  Moco
//
//  Created by Carissa Farry Hilmi Az Zahra on 17/10/23.
//

import SwiftUI

struct FindHoney: View {
    @Environment(\.audioViewModel) private var audioViewModel

    @Binding var isPromptDone: Bool

    @State private var showPopUp = false
    
    var doneHandler: (() -> Void)?

    var body: some View {
        VStack {
            Image("Story/Content/Story1/Pages/Page4/honey")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 120)
                .position(
                    x: 350,
                    y: 800
                )
//                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
                .onTapGesture {
                    print("")
                    audioViewModel.playSound(soundFileName: "success")
                    showPopUp = true
                }

            Image("Story/Content/Story1/Pages/Page4/cover-leaves")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .popUp(isActive: $showPopUp, title: "Selamat kamu berhasil menemukan Madu!") {
            isPromptDone = true
            doneHandler?()
        }
    }
}

#Preview {
    FindHoney(isPromptDone: .constant(false))
}
