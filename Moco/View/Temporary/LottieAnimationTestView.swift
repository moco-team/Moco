//
//  LottieAnimationTestView.swift
//  Moco
//
//  Created by Daniel Aprillio on 17/10/23.
//

import SwiftUI

struct LottieAnimationTestView: View {
    var body: some View {
        VStack {
            LottieView(fileName: "testing-cat.json", width: 75, height: 75)
                .padding()
        }
    }
}

#Preview {
    LottieAnimationTestView()
}
