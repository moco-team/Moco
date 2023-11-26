//
//  Buttons.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 13/10/23.
//

import SwiftUI

struct SfxButton<Content: View>: View {
    @Environment(\.audioViewModel) private var audioViewModel

    var soundName = "button_tap"

    var action: () -> Void
    @ViewBuilder var label: () -> Content

    var body: some View {
        Button {
            action()
            audioViewModel.playSound(
                soundFileName: soundName,
                category: .soundEffect
            )
        } label: {
            label()
        }
    }
}

extension SfxButton where Content == AnyView {
    /// Creates a button that generates its label from a localized string key.
    ///
    /// - Parameters:
    ///   - title: The key for the button's localized title, that describes
    ///     the purpose of the button's `action`.
    ///   - action: The action to perform when the user triggers the button.
    init(_ title: String, action: @escaping () -> Void, soundName: String = "button_tap") {
        self.init(soundName: soundName) {
            action()
        } label: {
            AnyView(Text(title))
        }
    }
}

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
    var fontSize = UIDevice.isIPad ? CGFloat(20) : CGFloat(16)
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(type == .success ? .text.green : type == .warning ? .text.brown : .text.red)
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            .shadow(radius: 2, y: 3)
            .customFont(.cherryBomb, size: fontSize)
            .background {
                Image(type == .success ?
                    "Buttons/button-success" : type == .warning ?
                    "Buttons/button-warning" : "Buttons/button-negative"
                )
                .resizable()
                .scaledToFill()
            }
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
        VStack {
            SfxButton(soundName: "non_existing_sound") {
                print("Button pressed!")
            } label: {
                Text("Press meeeeee")
            }
            .buttonStyle(MainButton(width: 180))
            .customFont(.cherryBomb, size: 20)
        }
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
