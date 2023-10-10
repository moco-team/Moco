//
//  ContentView.swift
//  KiwChing
//
//  Created by Aaron Christopher Tanhar on 10/10/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        HomeView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
