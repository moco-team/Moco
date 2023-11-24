//
//  ContentView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 11/10/23.
//

import SwiftData
import SwiftUI

// !!!: - Jangan Diubah
struct ContentView: View {
    @State private var isActive = false

    var body: some View {
        // MARK: - First View Declaration

        if isActive {
            HomeView()
        } else {
            SplashScreen(isActive: $isActive)
        }
    }
}

#Preview {
    ContentViewContainer()
}
