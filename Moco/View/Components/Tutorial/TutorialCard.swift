//
//  TutorialCard.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 31/10/23.
//

import SwiftUI

struct TutorialCard<Content: View>: View {
    @State var width: CGFloat = 300
    @State var height: CGFloat = 300
    @State var cornerRadius: CGFloat = 20
    @State var backgroundColorTop: Color = .clear
    @State var backgroundColorBottom: Color = .clear
    @State var borderColor: Color = .gray
    @State var backgroundImage: String
    var content: () -> Content?

    init(
        width: CGFloat = Screen.width * 0.5,
        height: CGFloat = Screen.height * 0.5,
        cornerRadius: CGFloat = 20,
        backgroundColorTop: Color = Color.clear,
        backgroundColorBottom: Color = Color.clear,
        borderColor: Color = Color.white,
        backgroundImage: String = "",
        @ViewBuilder component: @escaping () -> Content?
    ) {
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.backgroundColorTop = backgroundColorTop
        self.backgroundColorBottom = backgroundColorBottom
        self.borderColor = borderColor
        self.backgroundImage = backgroundImage
        content = component
    }

    var body: some View {
        VStack {
            if content() != nil {
                content()
            }
        }
        .frame(width: width, height: height).overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(lineWidth: 2)
                .foregroundColor(borderColor)
        )
        .background(LinearGradient(colors: [backgroundColorTop, backgroundColorBottom],
                                   startPoint: .top,
                                   endPoint: .center))
        .cornerRadius(cornerRadius)
    }
}

struct TutorialCard_Previews: PreviewProvider {
    static var previews: some View {
        TutorialCard(component: { VStack {}})
    }
}
