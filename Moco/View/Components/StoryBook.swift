//
//  StoryBook.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 14/10/23.
//

import SwiftUI

struct StoryBook: View {
    // MARK: - Stored variable definition

    var title: String = "Story 1"
    let durationAndDelay: CGFloat = 0.3
    @State var degree = 0.0
    @State var isFlipped = false

    var tapHandler: (() -> Void)?

    // MARK: - Flip Card Function

    func flipCard() {
        isFlipped.toggle()
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)) {
                degree = -90
            } completion: {
                tapHandler?()
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                degree = 0
            }
        }
    }

    var body: some View {
        VStack {
            VStack {
                Text(title)
                Image("Story/Cover/Story1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 400, alignment: .center)
                    .clipped()
            }.padding().border(.black).rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0), anchor: .leading, perspective: 0.5)
                .onTapGesture {
                    flipCard()
                }
        }.padding()
            .onAppear {
                isFlipped = false
                degree = 0.0
            }
    }
}

#Preview {
    StoryBook()
}
