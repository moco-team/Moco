//
//  PopUpExtension.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 15/10/23.
//

import SwiftUI

public extension View {
    func popUp(
        isActive: Binding<Bool>,
        title: String? = "Congratulation",
        text: String? = "",
        topImage: String? = nil,
        bottomImage: String? = nil,
        cancelText: String? = nil,
        confirmText: String? = nil,
        containerBgColor: Color = Color.white,
        textColor: Color = .black,
        overlayOpacity: Double = 0.3,
        withConfetti: Bool = false,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        function: @escaping () -> Void,
        cancelHandler: (() -> Void)? = {}
    ) -> some View {
        modifier(
            PopUpComponent(
                isActive: isActive,
                title: title,
                text: text,
                topImage: topImage,
                bottomImage: bottomImage,
                cancelText: cancelText,
                confirmText: confirmText ?? "Lanjut",
                containerBgColor: containerBgColor,
                textColor: Color.blue2Txt,
                overlayOpacity: overlayOpacity,
                width: width ?? Screen.width * 0.32,
                height: height ?? Screen.height * 0.3,
                withConfetti: withConfetti
            ) {
                function()
            } cancelHandler: {
                (cancelHandler ?? {})()
            }
        )
    }
}
