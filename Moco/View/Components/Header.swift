//
//  Header.swift
//  Moco
//
//  Created by Nur Azizah on 12/10/23.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack {
            Spacer()

            HStack(spacing: 15) {
                Button(action: {}, label: {
                    ImageStyleButton(imageName: "trophy.circle.fill")
                })
                .buttonStyle(CircleButton(width: 50, height: 50, backgroundColor: Color.black, foregroundColor: Color.white, animation: Animation.easeOut(duration: 0.2)))

                Button(action: {}, label: {
                    ImageStyleButton(imageName: "person.crop.circle.fill")
                })
                .buttonStyle(CircleButton(width: 50, height: 50, backgroundColor: Color.black, foregroundColor: Color.white, animation: Animation.easeOut(duration: 0.2)))
            }
        }
    }
}

#Preview {
    Header()
}
