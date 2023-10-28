//
//  SettingsView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 15/10/23.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.navigate) private var navigate
    @Environment(\.audioViewModel) private var audioViewModel
    @State var settingsViewModel = SettingsViewModel()

    var body: some View {
        HStack {
            Image(systemName: "speaker.fill")
                .foregroundColor(Color.black)

            Slider(value: $settingsViewModel.backsoundVolume,
                   in: 0 ... 1,
                   step: 0.01) { _ in
                audioViewModel.setVolume(Float(settingsViewModel.backsoundVolume))
            }.foregroundColor(.black).accentColor(.black)

            Image(systemName: "speaker.wave.2.fill")
                .foregroundColor(Color.black)
        }
    }
}

#Preview {
    SettingsView()
}
