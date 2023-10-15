//
//  ContentViewContainer.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 15/10/23.
//

import SwiftUI

struct ContentViewContainer: View {
    var body: some View {
        ContentView().edgesIgnoringSafeArea(.all)
            .statusBar(hidden: true)
            .navigationDestination(for: Route.self) { route in
                Routes(route: route).edgesIgnoringSafeArea(.all)
                    .statusBar(hidden: true)
            }
    }
}

#Preview {
    ContentViewContainer()
}
