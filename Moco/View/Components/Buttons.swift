//
//  Buttons.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 13/10/23.
//

import SwiftUI

struct MainButton: ButtonStyle {
    enum MainButtonType {
        case success
        case warning
        case danger
    }

    var width: CGFloat?
    var height: CGFloat?
    var buttonColor = Color.redBtn
    var cornerRadius: CGFloat = 8
    var type = MainButtonType.success
    var fontSize = CGFloat(20)
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width, height: height)
            .padding()
            .background {
                Image(type == .success ?
                    "Buttons/button-success" : type == .warning ?
                    "Buttons/button-warning" : "Buttons/button-negative"
                )
                .resizable()
                .scaledToFit()
                .frame(width: width, height: height)
            }
            .foregroundColor(type == .success ? .text.green : type == .warning ? .text.brown : .text.red)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .shadow(radius: 2, y: 3)
            .customFont(.cherryBomb, size: fontSize)
    }
}

struct MainButtonOld: ButtonStyle {
    var width: CGFloat?
    var height: CGFloat?
    var buttonColor = Color.redBtn
    var cornerRadius: CGFloat = 8
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width, height: height)
            .padding()
            .background(buttonColor)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .fontWeight(.bold)
            .shadow(radius: 2, y: 3)
    }
}

struct MainButtonOutlined: ButtonStyle {
    var width: CGFloat?
    var height: CGFloat?
    var buttonColor = Color.redBtn
    var textColor = Color.text.primary
    var borderWidth: CGFloat = 3
    var cornerRadius: CGFloat = 8
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width, height: height)
            .padding()
            .background(.clear)
            .foregroundColor(textColor)
            .clipShape(
                RoundedRectangle(cornerRadius: cornerRadius)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(buttonColor, lineWidth: borderWidth)
            )
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .fontWeight(.bold)
            .shadow(radius: 2, y: 3)
    }
}

struct BrownButton: ButtonStyle {
    var width: CGFloat?
    var height: CGFloat?
    var active: Bool = true
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width, height: height)
            .padding()
            .background(active ? .brown : .white)
            .foregroundColor(active ? .white : .black)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .shadow(radius: 2, y: 3)
            .fontWeight(.bold)
    }
}

struct ButtonView: View {
    @State var active = false
    var body: some View {
        Button("Press Me") {
            print("Button pressed!")
        }
        .buttonStyle(MainButton(width: 180))
        .customFont(.cherryBomb, size: 20)
        Button("Press Me") {
            print("Button pressed!")
        }
        .buttonStyle(MainButton(width: 180, type: .warning))
        .customFont(.cherryBomb, size: 20)
        Button("Press Me") {
            print("Button pressed!")
        }
        .buttonStyle(MainButtonOld(width: 80))
        Button("Press Me") {
            print("Button pressed!")
        }
        .buttonStyle(MainButtonOutlined(width: 80))
        Button("Press Me") {
            print("Button pressed!")
            active = !active
        }
        .buttonStyle(BrownButton(width: 80, active: active))
    }
}

#Preview {
    ButtonView()
}
