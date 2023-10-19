//
//  ContentViewContainer.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 15/10/23.
//

import SwiftUI

struct ContentViewContainer: View {
    var body: some View {
        ContentView().rootViewModifier()
            .navigationDestination(for: Route.self) { route in
                Routes(route: route).rootViewModifier()
            }
    }
}

#Preview {
    ContentViewContainer()
}
