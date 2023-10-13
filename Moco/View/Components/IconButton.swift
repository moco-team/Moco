//
//  IconButton.swift
//  Moco
//
//  Created by Nur Azizah on 12/10/23.
//

import Foundation
import SwiftUI

struct CircleButton: ButtonStyle {
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
            .clipShape(Circle())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(animation, value: configuration.isPressed)
            .shadow(radius: 2, y: 3)
    }
}

struct RoundedRectangleButton: ButtonStyle {
    var width: CGFloat = 30
    var height: CGFloat = 30
    var backgroundColor = Color.white
    var foregroundColor = Color.black
    var animation = Animation.easeOut(duration: 0.2)
    var cornerRadius: CGFloat = 15
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: width, height: height)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(animation, value: configuration.isPressed)
            .shadow(radius: 2, y: 3)
    }
}

struct ImageStyleButton: View {
    var imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
    }
}
