//
//  GestureList.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 31/10/23.
//

import SwiftUI

// var gestureList = [
//    Gesture(id: "1", name: "swipe", image: "hand.swipe.left", descriptionGesture: "untuk memutar dunia"),
//    Gesture(id: "2", name: "pinch", image: "hand.zoom", descriptionGesture: "untuk perbesar/perkecil dunia"),
//    Gesture(id: "3", name: "tap", image: "hand.tap", descriptionGesture: "untuk memilih barang")
// ]

var gestureList = [
    Gesture(id: "1", image: "hand.swipe.left"),
    Gesture(id: "2", image: "hand.zoom"),
    Gesture(id: "3", image: "hand.tap")
]

var gestureDescriptionViewList = [
    AnyView(
        Text("swipe")
            .font(.body)
            .fontWeight(Font.Weight.regular)
            .foregroundColor(Color.text.primary)
            +
            Text(" ")
            +
            Text("untuk memutar dunia")
            .font(.body)
            .fontWeight(Font.Weight.regular)
            .foregroundColor(Color.text.primary)
    ),
    AnyView(
        VStack {
            AnyView(Text("pinch")
                .font(.body)
                .fontWeight(Font.Weight.regular)
                .foregroundColor(Color.text.primary)
                +
                Text(" ")
                +
                Text("untuk perbesar/perkecil")
                .font(.body)
                .fontWeight(Font.Weight.regular)
                .foregroundColor(Color.text.primary))
            Text("dunia")
                .font(.body)
                .fontWeight(Font.Weight.regular)
                .foregroundColor(Color.text.primary)
        }
    ),
    AnyView(
        Text("swipe")
            .font(.body)
            .fontWeight(Font.Weight.regular)
            .foregroundColor(Color.text.primary)
            +
            Text(" ")
            +
            Text("untuk memutar dunia")
            .font(.body)
            .fontWeight(Font.Weight.regular)
            .foregroundColor(Color.text.primary)
    )
]
