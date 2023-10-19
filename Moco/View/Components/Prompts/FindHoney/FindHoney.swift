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
        ZStack {
            VStack {
                Image("Story/Content/Story1/Pages/Page4/honey")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .position(
                        x: 350,
                        y: 850
                    )
                
                Image("Story/Content/Story1/Pages/Page4/cover-leaves")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .popUp(isActive: $showPopUp, title: "Selamat kamu berhasil menemukan Madu!") {
                isPromptDone = true
                doneHandler?()
            }
            
            InvisibleButton {
                print("Object found!")
                audioViewModel.playSound(soundFileName: "success")
                showPopUp = true
            }
            .frame(width: 120, height: 120)
            .position(
                x: 350,
                y: 850
            )
        }
        
    }
}

#Preview {
    FindHoney(isPromptDone: .constant(false))
}
