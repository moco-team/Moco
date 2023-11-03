//
//  GestureList.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 31/10/23.
//

import SwiftUI

var gestureList = [
    Gesture(id: "1", image: "hand.tap"),
    Gesture(id: "2", image: "hand.tap")
]

var gestureDescriptionViewList = [
    AnyView(
        Text("Tap")
            .font(.body)
            .fontWeight(Font.Weight.regular)
            .foregroundColor(Color.text.primary)
            +
            Text(" ")
            +
            Text("untuk meletakkan Pulau")
            .font(.body)
            .fontWeight(Font.Weight.regular)
            .foregroundColor(Color.text.primary)
    ),
    AnyView(
        VStack {
            AnyView(Text("Tap")
                .font(.body)
                .fontWeight(Font.Weight.regular)
                .foregroundColor(Color.text.primary)
                +
                Text(" ")
                +
                Text("jika menemukan benda yang dicari")
                .font(.body)
                .fontWeight(Font.Weight.regular)
                .foregroundColor(Color.text.primary))
        }
    ),
    AnyView(
        VStack {
            Button {
                print("Hint!")
            } label: {
                Image("Buttons/button-hint")
                    .resizable()
                    .scaledToFit()
                    .padding(15)
            }
            .buttonStyle(
                CircleButton(
                    width: 80,
                    height: 80,
                    backgroundColor: .clear,
                    foregroundColor: .clear
                )
            )
            .padding(50)

            AnyView(Text("Tombol Hint")
                .font(.body)
                .fontWeight(Font.Weight.regular)
                .foregroundColor(Color.text.primary)
                +
                Text(" ")
                +
                Text("untuk melihat petunjuk")
                .font(.body)
                .fontWeight(Font.Weight.regular)
                .foregroundColor(Color.text.primary))
        }
    )
]
