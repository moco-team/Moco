//
//  SettingsView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 15/10/23.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.navigate) private var navigate

    var body: some View {
        Button("Hello, World!") {
            navigate.pop(2)
        }
    }
}

#Preview {
    SettingsView()
}
