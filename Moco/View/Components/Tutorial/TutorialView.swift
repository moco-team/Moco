//
//  TutorialView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 31/10/23.
//

import SwiftUI

struct TutorialView: View {
    @Binding var tabs: [Gesture]
    @Binding var currentIndex: Int

    @State var fakeIndex: Int = 0

    @State var offset: CGFloat = 0

    @State var genericTabs: [Gesture] = []

    var onClose: () -> Void = {}

    var body: some View {
        VStack {
            TutorialCard(width: 280, height: 320, cornerRadius: 31, backgroundColorTop: Color.primary, backgroundColorBottom: Color.primary, borderColor: Color.primary, backgroundImage: "") {
                Spacer().frame(height: 25)
                HStack(content: {
                    Spacer()
                    Button(action: {
                        onClose()
                    }, label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 15, height: 15, alignment: Alignment.trailing)
                            .foregroundColor(Color.text.primary)
                            .bold()
                            .padding(.horizontal, 30)
                    })
                })

                AppJosefineSans(text: "Gesture Permainan", size: .title2, fontWeight: Font.Weight.bold, fontColor: Color.primary, textAligment: TextAlignment.center)
                    .padding()

                TutorialCarouselView(tabs: $tabs, currentIndex: $currentIndex)
            }
            .shadow(color: Color.primary, radius: 5, x: 0, y: 0)
            .padding(5)
        }
    }
}

// struct TutorialView_Previews: PreviewProvider {
//    static var previews: some View {
//        TutorialView()
//    }
// }
