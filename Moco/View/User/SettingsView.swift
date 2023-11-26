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
        VStack {
            Image("Buttons/button-home")
                .resizable()
                .frame(width: 70, height: 70)
                .shadow(radius: 4, x: -2, y: 2)
                .onTapGesture {
                    navigate.pop()
                }

            Text("Backsound")
            HStack {
                Image(systemName: "speaker.fill")
                    .foregroundColor(Color.black)

                Slider(value: $settingsViewModel.backsoundVolume,
                       in: 0 ... 1,
                       step: 0.01) { _ in
                    audioViewModel
                        .setVolumeByCategory(
                            Float(
                                settingsViewModel.backsoundVolume),
                            category: .backsound
                        )
                }.foregroundColor(.black).accentColor(.black)

                Image(systemName: "speaker.wave.2.fill")
                    .foregroundColor(Color.black)
            }
            Text("Narration")
            HStack {
                Image(systemName: "speaker.fill")
                    .foregroundColor(Color.black)

                Slider(value: $settingsViewModel.narrationVolume,
                       in: 0 ... 1,
                       step: 0.01) { _ in
                    audioViewModel
                        .setVolumeByCategory(
                            Float(
                                settingsViewModel.narrationVolume),
                            category: .narration
                        )
                }.foregroundColor(.black).accentColor(.black)

                Image(systemName: "speaker.wave.2.fill")
                    .foregroundColor(Color.black)
            }
            Text("Sound effect")
            HStack {
                Image(systemName: "speaker.fill")
                    .foregroundColor(Color.black)

                Slider(value: $settingsViewModel.soundEffectVolume,
                       in: 0 ... 1,
                       step: 0.01) { _ in
                    audioViewModel
                        .setVolumeByCategory(
                            Float(
                                settingsViewModel.soundEffectVolume),
                            category: .soundEffect
                        )
                }.foregroundColor(.black).accentColor(.black)

                Image(systemName: "speaker.wave.2.fill")
                    .foregroundColor(Color.black)
            }
        }
        .foregroundColor(.text.darkBlue)
        .background {
            Image("Story/main-background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    SettingsView()
}
