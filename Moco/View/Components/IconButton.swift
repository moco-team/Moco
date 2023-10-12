//
//  IconButton.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 12/10/23.
//

import SwiftUI

struct IconButton: ButtonStyle {
    var width: CGFloat = 30
    var height: CGFloat = 30
    var backgroundColor = Color.white
    var foregroundColor = Color.black
    var animation = Animation.easeOut(duration: 0.2)
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width, height: height)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(animation, value: configuration.isPressed)
            .shadow(radius: 2, y: 3)
    }
}

struct IconButtonRect: ButtonStyle {
    var width: CGFloat = 30
    var height: CGFloat = 30
    var backgroundColor = Color.white
    var foregroundColor = Color.black
    var animation = Animation.easeOut(duration: 0.2)
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width, height: height)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 8, height: 8)))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(animation, value: configuration.isPressed)
            .shadow(radius: 2, y: 3)
    }
}

struct SettingsButtonView: View {
    var body: some View {
        VStack {
            Button {
                print("Button pressed!")
            } label: {
                Image(systemName: "gearshape")
            }.buttonStyle(IconButton(width: 30, height: 30, backgroundColor: .green, foregroundColor: .red))
            Button {
                print("Button pressed!")
            } label: {
                Image(systemName: "gearshape")
            }.buttonStyle(IconButtonRect(width: 30, height: 30, backgroundColor: .purple, foregroundColor: .red, animation: .easeOut(duration: 0.6)))
        }
    }
}

#Preview {
    SettingsButtonView()
}
