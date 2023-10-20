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
        Button("Achievements View") {
            navigate.pop(2)
        }
    }
}

#Preview {
    AchievementsView()
}
