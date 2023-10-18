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
        DetectionView()
    }
}

#Preview {
    CollectionView()
        .modelContainer(for: CollectionModel.self, inMemory: true)
}
