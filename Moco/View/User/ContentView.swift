//
//  ContentView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 11/10/23.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    var body: some View {
        // MARK: - First View Declaration

        HomeView()
        
//        SpeakTheStory(
//            isPromptDone: .constant(false),
//            hints: ["Page3-monolog1"],
//            correctAnswer: "Page3-monolog1"
//        )
    }
}

#Preview {
    CollectionView()
        .modelContainer(for: CollectionModel.self, inMemory: true)
}
