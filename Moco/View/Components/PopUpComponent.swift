//
//  PopUpComponent.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 13/10/23.
//

import ConfettiSwiftUI
import SwiftUI

public enum PopUpType {
    case base
    case danger
}

struct PopUpComponent: ViewModifier {
    @State private var offset: CGFloat = 1000
    @Binding var isActive: Bool
    @State private var confettiCounter = 0

    var title = "Congratulations"
    var text: String? = ""

    var topImage: String?
    var bottomImage: String?
    var cancelText: String?
    var confirmText = "Yes"
    var containerBgColor = Color.white
    var textColor = Color.black
    var overlayOpacity = 0.3
    var isLarge = false
    var width = Screen.width * 0.45
    var height = Screen.height * 0.6
    var type = PopUpType.base
    var disableCancel = false

    var withConfetti = false

    var closeWhenDone = false
    var shakeItOff: CGFloat = 0

    var function: () -> Void
    var cancelHandler: (() -> Void)?

    func body(content: Content) -> some View {
        ZStack {
            content.ignoresSafeArea()
            if isActive {
                PopUpComponentView(
                    isActive: $isActive,
                    title: title,
                    text: text,
                    withConfetti: withConfetti,
                    topImage: topImage,
                    bottomImage: bottomImage,
                    cancelText: cancelText,
                    confirmText: confirmText,
                    containerBgColor: containerBgColor,
                    textColor: textColor,
                    overlayOpacity: overlayOpacity,
                    width: width,
                    height: height,
                    closeWhenDone: closeWhenDone,
                    shakeItOff: shakeItOff,
                    type: type,
                    disableCancel: disableCancel
                ) {
                    function()
                } cancelHandler: {
                    cancelHandler?()
                }
                .id(isActive)
            }
        }
    }
}

struct PopUpComponentView: View {
    @Environment(\.audioViewModel) private var audioViewModel
    @Environment(\.timerViewModel) private var timerViewModel
    @State private var offset: CGFloat = 1000
    @Binding var isActive: Bool
    @State private var confettiCounter = 0
    @State private var internalOverlayOpacity = 0.0
    @State private var shakeAnimatableData: CGFloat = 0

    var title = "Congratulations"
    var text: String? = ""
    var withConfetti = false

    var topImage: String?
    var bottomImage: String?
    var cancelText: String?
    var confirmText = "Yes"
    var containerBgColor = Color.white
    var textColor = Color.blue2Txt
    var overlayOpacity = 0.3
    var isLarge = false
    var width = Screen.width * 0.45
    var height = Screen.height * 0.6
    var closeWhenDone = false
    var shakeItOff: CGFloat = 0
    var type = PopUpType.base

    var disableCancel = false

    var function: () -> Void
    var cancelHandler: (() -> Void)?

    var body: some View {
        ZStack {
            Color(.black)
                .opacity(internalOverlayOpacity)
                .onTapGesture {
                    guard !disableCancel else { return }
                    close()
                }
            VStack(alignment: .center, spacing: 0) {
                ZStack {
                    if topImage != nil {
                        Image(topImage!)
                            .resizable()
                            .scaledToFit().frame(width: 200)
                            .padding(.top, -190)
                            .padding(.leading, -100)
                    }
                    VStack {
                        Spacer()

                        Text(title)
                            .customFont(.cherryBomb, size: UIDevice.isIPad ? 32 : 24)
                            .fontWeight(.heavy)
                            .foregroundColor(textColor)
                            .glowBorder(color: .white, lineWidth: 5)
                            .padding(.top, 10)
                            .padding(.bottom, 20)
                            .padding(.horizontal, 10)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)

                        if text != "" {
                            Text(text ?? "")
                                .foregroundColor(textColor)
                                .font(.footnote)
                                .padding(.bottom, 23)
                                .padding(.horizontal, 70)
                                .multilineTextAlignment(.center)
                        }

                        Spacer()

                        Grid(horizontalSpacing: 0) {
                            GridRow {
                                if cancelText != nil {
                                    Spacer()
                                    SfxButton(cancelText!) {
                                        if cancelHandler != nil {
                                            cancelHandler!()
                                        }
                                        close()
                                    }
                                    .buttonStyle(MainButton(width: 180, type: .warning))
                                    .font(.footnote)
                                }
                                Spacer()
                                SfxButton(confirmText) {
                                    function()
                                    if closeWhenDone {
                                        close()
                                    }
                                }
                                .buttonStyle(MainButton(width: 180, type: .success))
                                .font(.footnote)
                                .shake(animatableData: shakeItOff)
                                Spacer()
                            }
                        }
                        .padding(.bottom)
                    }.padding(20)
                        .overlay(alignment: .topTrailing) {
                            if !disableCancel {
                                SfxButton {
                                    close()
                                } label: {
                                    Image("Buttons/button-x")
                                        .resizable()
                                        .frame(
                                            width: UIDevice.isIPad ? 50 : 40,
                                            height: UIDevice.isIPad ? 50 : 40
                                        )
                                        .shadow(radius: 20, x: -20, y: 20)
                                }
                            }
                        }
                    if bottomImage != nil {
                        Image(bottomImage!)
                            .resizable()
                            .scaledToFit().frame(width: 110)
                            .padding(.top, 210)
                            .padding(.leading, 240)
                    }
                }
                .background {
                    switch type {
                    case .base:
                        Image(isLarge ?
                            "Components/popup-base-lg" :
                            "Components/popup-base")
                            .resizable()
                            .scaledToFill()
                    case .danger:
                        Image(isLarge ?
                            "Components/popup-base-lg" :
                            "Components/popup-danger")
                            .resizable()
                            .scaledToFill()
                    }
                }
                .frame(maxWidth: width, maxHeight: height)
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
                    audioViewModel.playSound(soundFileName: "congratulation-popup")
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

struct PopUpComponentViewOld: View {
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
    var confirmText = "Yes"
    var containerBgColor = Color.white
    var textColor = Color.black
    var overlayOpacity = 0.3
    var width = Screen.width * 0.45
    var height = Screen.height * 0.4

    var function: () -> Void
    var cancelHandler: (() -> Void)?

    var body: some View {
        ZStack {
            Color(.black)
                .opacity(internalOverlayOpacity)
                .frame(width: Screen.width, height: Screen.height)
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
                            .foregroundColor(containerBgColor)
                            .cornerRadius(10)

                        VStack {
                            Text(title ?? "Congratulations")
                                .customFont(.cherryBomb, size: 22)
                                .foregroundColor(textColor)
                                .padding(.top, 10)
                                .padding(.bottom, 20)
                                .fixedSize(horizontal: false, vertical: true)
                            Text(text ?? "")
                                .foregroundColor(textColor)
                                .font(.footnote)
                                .padding(.bottom, 23)
                                .padding(.horizontal, 70)
                                .multilineTextAlignment(.center)
                            Grid(horizontalSpacing: 20) {
                                GridRow {
                                    if cancelText != nil {
                                        Button(cancelText!) {
                                            if cancelHandler != nil {
                                                cancelHandler!()
                                            }
                                            close()
                                        }
                                        .buttonStyle(MainButton(width: 180, type: .warning))
                                        .font(.footnote)
                                    }
                                    Button(confirmText) {
                                        function()
                                    }
                                    .buttonStyle(MainButton(width: 180, type: .success))
                                    .font(.footnote)
                                }
                            }
                        }
                        .padding(.vertical, 40)
                        .padding(40)

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
                    Image("Buttons/button-x").resizable().frame(width: 50, height: 50)
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

struct PopUpPreview: View {
    @State var isActive: Bool = true
    var body: some View {
        Button("Waduh") {
            isActive = true
            print(isActive)
        }.popUp(isActive: $isActive, title: "Yakin mau keluar?", text: "", cancelText: "Cancel", withConfetti: true) {
            print("Done")
        } cancelHandler: {
            print("Cancel")
        }
    }
}

#Preview {
    PopUpPreview()
}
