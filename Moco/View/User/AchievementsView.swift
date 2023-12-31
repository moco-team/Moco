//
//  AchievementsView.swift
//  Moco
//
//  Created by Daniel Aprillio on 20/10/23.
//

import SwiftUI

struct AchievementsView: View {
    @Environment(\.navigate) private var navigate

    var body: some View {
        VStack {
            Image("Buttons/button-home")
                .resizable()
                .frame(width: 70, height: 70)
                .shadow(radius: 4, x: -2, y: 2)
                .foregroundColor(.white)
                .onTapGesture {
                    navigate.pop()
                }

            Button("Achievements View") {
                navigate.pop(2)
            }
        }
    }
}

#Preview {
    AchievementsView()
}
