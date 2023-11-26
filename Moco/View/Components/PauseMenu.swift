//
//  PauseMenu.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 09/11/23.
//

import SwiftUI

struct PauseMenu: View {
    @Environment(\.audioViewModel) private var audioViewModel
    @State var settingsViewModel = SettingsViewModel()

    @State private var offset: CGFloat = 1000
    @Binding var isActive: Bool
    @State private var confettiCounter = 0
    @State private var internalOverlayOpacity = 0.0

    var title: String? = "Congratulations"
    var text: String? = ""
    var withConfetti = false

    var topImage: String?
    var bottomImage: String?
    var cancelText: String?
    var confirmText = "TUTORIAL"
    var containerBgColor = Color.white
    var textColor = Color.blue2Txt
    var overlayOpacity = 0.3
    var isLarge = true
    var width = Screen.width * 0.5
    var height = Screen.height * 0.6

    var function: () -> Void
    var repeatHandler: (() -> Void)?
    var cancelHandler: (() -> Void)?

    var buttonWidth: CGFloat {
        UIDevice.isIPad ? 250 : 125
    }

    var buttonHeight: CGFloat {
        UIDevice.isIPad ? 120 : 60
    }

    var buttonFontSize: CGFloat {
        UIDevice.isIPad ? 30 : 15
    }

    var body: some View {
        ZStack {
            Color(.black)
                .opacity(internalOverlayOpacity)
                .onTapGesture {
                    close()
                }
            VStack(alignment: .center, spacing: 0) {
                HStack(alignment: .center) {
                    ZStack {
                        if topImage != nil {
                            Image(topImage!)
                                .resizable()
                                .scaledToFit().frame(width: 200)
                                .padding(.top, -190)
                                .padding(.leading, -100)
                        }

                        Rectangle().frame(width: width, height: height)
                            .foregroundColor(.clear)
                            .overlay {
                                Image(isLarge ? "Components/popup-base-lg" : "Components/popup-base").resizable().scaledToFit()
                            }

                        VStack {
                            HStack {
                                Image(systemName: "speaker.wave.2.fill")
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
                                }.foregroundColor(.black).accentColor(.black).tint(.text.brown2)
                            }.padding(.horizontal, 90)

                            SfxButton("ULANGI") {
                                repeatHandler?()
                                close()
                            }
                            .buttonStyle(MainButton(width: buttonWidth, height: buttonHeight, type: .danger, fontSize: buttonFontSize))
                            SfxButton(confirmText) {
                                function()
                                close()
                            }
                            .buttonStyle(MainButton(width: buttonWidth, height: buttonHeight, type: .success, fontSize: buttonFontSize))
                        }

                        if bottomImage != nil {
                            Image(bottomImage!)
                                .resizable()
                                .scaledToFit().frame(width: 110)
                                .padding(.top, 210)
                                .padding(.leading, 240)
                        }
                    }.frame(width: width, height: height)
                }
            }
            .overlay(alignment: .topTrailing) {
                SfxButton {
                    close()
                } label: {
                    Image("Buttons/button-x")
                        .resizable()
                        .frame(width:  UIDevice.isIPad ? 80 : 50, height:  UIDevice.isIPad ? 80 : 50)
                        .shadow(radius: 20, x: -20, y: 20)
                }
            }
            .offset(x: 0, y: offset)
            .onAppear {
                offset = 1000
                withAnimation(.spring()) {
                    offset = 0
                    internalOverlayOpacity = overlayOpacity
                }
                if withConfetti {
                    confettiCounter += 1
                }
            }
        }
        .confettiCannon(counter: $confettiCounter, num: 30, confettiSize: 20, rainHeight: Screen.height * 1.2, radius: Screen.width * 0.4, repetitions: 2)
    }

    func close() {
        withAnimation(.spring()) {
            offset = 1000
            internalOverlayOpacity = 0
        } completion: {
            isActive = false
        }
    }
}

#Preview {
    PauseMenu(isActive: .constant(false)) {
        print("slsls")
    }
}
