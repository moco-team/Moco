//
//  PopUpComponent.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 13/10/23.
//

import SwiftUI

struct PopUpComponent: ViewModifier {
    @State private var offset: CGFloat = 1000
    @Binding var isActive: Bool

    var title: String? = "Congratulations"
    var text: String? = ""

    var topImage: String?
    var bottomImage: String?
    var cancelText: String?
    var confirmText = "Yes"
    var containerBgColor = Color.white
    var textColor = Color.black
    var overlayOpacity = 0.3
    var width = Screen.width * 0.3
    var height = Screen.height * 0.2

    var function: () -> Void
    var cancelHandler: (() -> Void)?

    func body(content: Content) -> some View {
        if isActive {
            content.overlay {
                PopUpComponentView(
                    isActive: $isActive,
                    title: title,
                    text: text,
                    topImage: topImage,
                    bottomImage: bottomImage,
                    cancelText: cancelText,
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
            }
        } else {
            content
        }
    }
}

struct PopUpComponentView: View {
    @State private var offset: CGFloat = 1000
    @Binding var isActive: Bool

    var title: String? = "Congratulations"
    var text: String? = ""

    var topImage: String?
    var bottomImage: String?
    var cancelText: String?
    var confirmText = "Yes"
    var containerBgColor = Color.white
    var textColor = Color.black
    var overlayOpacity = 0.3
    var width = Screen.width * 0.3
    var height = Screen.height * 0.25

    var function: () -> Void
    var cancelHandler: (() -> Void)?

    var body: some View {
        ZStack {
            Color(.black)
                .opacity(overlayOpacity)
                .frame(width: Screen.width, height: Screen.height)
                .onTapGesture {
                    close()
                }
            VStack(alignment: .center) {
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
                            Text(title ?? "Congratulations").customFont(.cherryBomb, size: 22)
                                .foregroundColor(textColor)
                                .padding(.top, 10)
                                .padding(.bottom, 20)
                                .fixedSize(horizontal: false, vertical: true)
                            Text(text ?? "")
                                .foregroundColor(textColor)
                                .font(.footnote)
                                .padding(.bottom, 23)
                                .padding(.horizontal, 90)
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
                                        .buttonStyle(MainButton(width: 80, height: 10, buttonColor: Color.redBtn))
                                        .font(.footnote)
                                    }
                                    Button(confirmText) {
                                        function()
                                    }
                                    .buttonStyle(MainButton(width: 80, height: 10, buttonColor: Color.greenBtn))
                                    .font(.footnote)
                                }
                            }
                        }
                        .padding(.vertical, 20)

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
                Button {
                    close()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .fontWeight(.medium)
                }
                .tint(.black)
                .padding()
            }
            .offset(x: 0, y: offset)
            .onAppear {
                withAnimation(.spring()) {
                    offset = 0
                }
            }
        }
    }

    func close() {
        withAnimation(.spring()) {
            offset = 1000
            isActive = false
        }
    }
}

#Preview {
    @State var isActive: Bool = true

    return PopUpComponentView(isActive: $isActive, title: "Are you sure you want to quit?", text: "Kareba", cancelText: "Cancel") {
        print("Claimed")
    } cancelHandler: {
        print("cancel handler")
    }
}
