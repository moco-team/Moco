//
//  MazeTutorialView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 07/11/23.
//

import SwiftUI

struct MazeTutorialView: View {
    var body: some View {
        VStack {
            Text("Tutorial")
            Text("Miringkan layar ke kanan")
            CircularProgressView(progress: Double(20) / 100.0, size: 60, width: 10) {
                progress in
                Text("\(progress * 100, specifier: "%.0f")%")
                    .customFont(.didactGothic, size: 20)
                    .bold()
            }
        }
    }
}

#Preview {
    MazeTutorialView()
}
