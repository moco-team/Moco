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
    var containerBgColor = Color.orange
    var textColor = Color.black
    var overlayOpacity = 0.3

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
                    overlayOpacity: overlayOpacity
                ) {
                    function()
                } cancelHandler: {
                    (cancelHandler ?? {})()
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
    var containerBgColor = Color.orange
    var textColor = Color.black
    var overlayOpacity = 0.3

    var function: () -> Void
    var cancelHandler: (() -> Void)?

    var body: some View {
        ZStack {
            Color(.black)
                .opacity(overlayOpacity)
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

                        Rectangle().frame(width: 300, height: 180)
                            .foregroundColor(containerBgColor)
                            .cornerRadius(10)

                        VStack {
                            Text(title ?? "Congratulations")
                                .foregroundColor(textColor)
                                .fontWeight(.bold)
                                .padding(.bottom, 1)
                            Text(text ?? "")
                                .foregroundColor(textColor)
                                .font(.footnote)
                                .padding(.bottom, 13)
                                .padding(.horizontal, 90)
                                .multilineTextAlignment(.center)
                            Grid {
                                GridRow {
                                    if cancelText != nil {
                                        Button(cancelText!) {
                                            if cancelHandler != nil {
                                                cancelHandler!()
                                            }
                                            close()
                                        }
                                        .buttonStyle(MainButton(width: 80, height: 10, buttonColor: .red))
                                        .font(.footnote)
                                    }
                                    Button(confirmText) {
                                        function()
                                    }
                                    .buttonStyle(MainButton(width: 80, height: 10, buttonColor: .green))
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
                    }
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

    return PopUpComponentView(isActive: $isActive, title: "Congrads", text: "Kareba", cancelText: "Cancel") {
        print("Claimed")
    } cancelHandler: {
        print("cancel handler")
    }
}
