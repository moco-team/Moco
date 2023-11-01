//
//  ModalComponent.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 01/11/23.
//

import ConfettiSwiftUI
import SwiftUI

struct ModalComponent: ViewModifier {
    @State private var offset: CGFloat = 1000
    @Binding var isActive: Bool
    @State private var confettiCounter = 0

    var title: String? = "Congratulations"
    var text: String? = ""

    var topImage: String?
    var bottomImage: String?
    var confirmText = "Yes"
    var containerBgColor = Color.white
    var textColor = Color.black
    var overlayOpacity = 0.3
    var width = Screen.width * 0.45
    var height = Screen.height * 0.6

    var withConfetti = false

    var function: () -> Void
    var cancelHandler: (() -> Void)?

    func body(content: Content) -> some View {
        if isActive {
            content.overlay {
                ModalComponentView(
                    isActive: $isActive,
                    title: title,
                    text: text,
                    withConfetti: withConfetti,
                    topImage: topImage,
                    bottomImage: bottomImage,
                    confirmText: confirmText,
                    containerBgColor: containerBgColor,
                    textColor: textColor,
                    overlayOpacity: overlayOpacity,
                    width: width,
                    height: height
                ) {
                    function()
                } cancelHandler: {
                    cancelHandler?()
                }
                .id(isActive)
            }
        } else {
            content
        }
    }
}

struct ModalComponentView: View {
    @State private var offset: CGFloat = 1000
    @Binding var isActive: Bool
    @State private var confettiCounter = 0
    @State private var internalOverlayOpacity = 0.0

    var title: String? = "Congratulations"
    var text: String? = ""
    var withConfetti = false

    var topImage: String?
    var bottomImage: String?
    var confirmText = "Yes"
    var containerBgColor = Color.white
    var textColor = Color.black
    var overlayOpacity = 0.3
    var width = Screen.width * 0.45
    var height = Screen.height * 0.6

    var function: () -> Void
    var cancelHandler: (() -> Void)?

    var body: some View {
        ZStack {
            Color(.black)
                .opacity(internalOverlayOpacity)
                .frame(width: Screen.width, height: Screen.height)
                .onTapGesture {
                    function()
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
                                Image("Components/modal-base").resizable().scaledToFit()
                            }

                        VStack {
                            Text(title ?? "Congratulations").customFont(.cherryBomb, size: 22)
                                .foregroundColor(textColor)
                                .padding(.top, 10)
                                .padding(.bottom, 20)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            if text != "" {
                                Text(text ?? "")
                                    .foregroundColor(textColor)
                                    .font(.footnote)
                                    .padding(.bottom, 23)
                                    .padding(.horizontal, 70)
                                    .multilineTextAlignment(.center)
                            }
                            
                            Grid(horizontalSpacing: 20) {
                                GridRow {
                                    Button(confirmText) {
                                        function()
                                    }
                                    .buttonStyle(MainButton(width: 180, type: .success))
                                    .font(.footnote)
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
                    }.frame(width: width, height: height)
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

struct ModalPreview: View {
    @State var isActive: Bool = true
    var body: some View {
        Button("Waduh") {
            isActive = true
            print(isActive)
        }.customModal(isActive: $isActive, title: "Yakin mau keluar?", withConfetti: true) {
            print("Done")
        } cancelHandler: {
            print("Cancel")
        }
    }
}

#Preview {
    ModalPreview()
}
