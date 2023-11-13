//
//  CardView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 13/11/23.
//

import SwiftUI

struct CardView: View {
    var state = CardState.inactive
    var revealedImage = ""
    var text = ""
    var suffix = ""

    var onTap: (() -> Void)?

    var body: some View {
        VStack {
            switch state {
            case .active:
                VStack {
                    Image("Story/Prompts/card-active")
                        .resizable()
                        .scaledToFit()
                        .onTapGesture {
                            onTap?()
                        }
                    Text(String(repeating: "_", count: text.count) + suffix)
                        .customFont(.didactGothic, size: 40)
                }
            case .inactive:
                Image("Story/Prompts/card-inactive")
                    .resizable()
                    .scaledToFit()
                Text(String(repeating: "_", count: text.count) + suffix)
                    .customFont(.didactGothic, size: 40)
            case .revealed:
                Image(revealedImage)
                    .resizable()
                    .scaledToFit()
                Text(text + suffix)
                    .customFont(.didactGothic, size: 40)
            }
        }.frame(width: 300, height: 400)
    }
}

#Preview {
    CardView()
}
