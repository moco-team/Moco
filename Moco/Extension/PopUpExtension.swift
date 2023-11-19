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
        title: String = "Congratulation",
        text: String? = "",
        topImage: String? = nil,
        bottomImage: String? = nil,
        cancelText: String? = nil,
        confirmText: String? = nil,
        containerBgColor: Color = Color.white,
        textColor _: Color = .black,
        overlayOpacity: Double = 0.3,
        isLarge: Bool = false,
        withConfetti: Bool = false,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        closeWhenDone: Bool = false,
        disableCancel: Bool = false,
        shakeItOff: CGFloat = 0,
        type: PopUpType = PopUpType.base,
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
                isLarge: isLarge,
                width: width ?? Screen.width * 0.32,
                height: height ?? Screen.height * 0.3,
                type: type,
                disableCancel: disableCancel,
                withConfetti: withConfetti,
                closeWhenDone: closeWhenDone,
                shakeItOff: shakeItOff
            ) {
                function()
            } cancelHandler: {
                (cancelHandler ?? {})()
            }
        )
    }
}
