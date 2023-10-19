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
        topImage: String? = nil,
        bottomImage: String? = nil,
        cancelText: String? = nil,
        confirmText: String? = nil,
        containerBgColor: Color = Color.white,
        textColor: Color = .black,
        overlayOpacity: Double = 0.3,
        width: CGFloat? = nil,
        height: CGFloat? = nil,
        function: @escaping () -> Void,
        cancelHandler: (() -> Void)? = {}
    ) -> some View {
        modifier(
            PopUpComponent(
                isActive: isActive,
                title: title,
                topImage: topImage,
                bottomImage: bottomImage,
                cancelText: cancelText,
                confirmText: confirmText ?? "Yes",
                containerBgColor: containerBgColor,
                textColor: textColor,
                overlayOpacity: overlayOpacity,
                width: width ?? Screen.width * 0.3,
                height: height ?? Screen.height * 0.2
            ) {
                function()
            } cancelHandler: {
                (cancelHandler ?? {})()
            }
        )
    }
}
