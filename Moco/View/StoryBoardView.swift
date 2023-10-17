//
//  StoryBoardView.swift
//  Moco
//
//  Created by Nur Azizah on 12/10/23.
//

import SwiftUI

struct StoryBoardView: View {
    var body: some View {
        VStack {
            VStack {
                Header()
                Spacer()
            }

            VStack {
                HStack {
                    Text("Pilih Koleksi")
                        .fontWeight(.bold)
                        .font(.title)
                    Spacer()
                }
            }
        }
        .padding(.bottom, 250)
        .padding([.trailing, .leading, .top], 40)
    }
}

#Preview {
    StoryBoardView()
}
