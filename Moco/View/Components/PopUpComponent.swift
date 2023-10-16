//
//  PopUpComponent.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 13/10/23.
//

import SwiftUI

struct PopUpComponents: View {
    var title: String? = "Congratulations"
    var text: String? = ""

    var topImage: String?
    var bottomImage: String?
    var cancelText: String?
    var confirmText = "Yes"
    var containerBgColor = Color.orange
    var textColor = Color.black

    var function: () -> Void
    var cancelHandler: (() -> Void)?

    var body: some View {
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
                                    }
                                    .buttonStyle(MainButton(width: 80, height: 10, buttonColor: .red))
                                    .font(.footnote)
                                }
                                Button(confirmText) {
                                    function()
                                }
                                .buttonStyle(MainButton(width: 80, height: 10))
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
    }
}

#Preview {
    PopUpComponents(title: "Congrads", text: "Kareba", cancelText: "Cancel") {
        print("Claimed")
    } cancelHandler: {
        print("cancel handler")
    }
}
