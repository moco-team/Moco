//
//  ModalViewModifier.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 01/11/23.
//

import SwiftUI

public extension View {
    func customModal(
        isActive: Binding<Bool>,
        title: String? = "Congratulation",
        text: String? = "",
        topImage: String? = nil,
        bottomImage: String? = nil,
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
            ModalComponent(
                isActive: isActive,
                title: title,
                text: text,
                topImage: topImage,
                bottomImage: bottomImage,
                confirmText: confirmText ?? "Lanjut",
                containerBgColor: containerBgColor,
                textColor: textColor,
                overlayOpacity: overlayOpacity,
                width: width ?? Screen.width * 0.5,
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
