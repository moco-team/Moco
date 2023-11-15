//
//  MazeProgress.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 07/11/23.
//

import SwiftUI

struct MazeProgress: View {
    @Environment(\.mazePromptViewModel) private var mazePromptViewModel

    var body: some View {
        HStack {
            GeometryReader {
                let size = $0.size
                ZStack {
                    Image("Maze/questioned-card").resizable().aspectRatio(contentMode: .fit)
                    Color.gray
                        .offset(y: -size.height * mazePromptViewModel.progress)
                        .mask {
                            Image("Maze/questioned-card").resizable().aspectRatio(contentMode: .fit)
                        }
                }.frame(width: Screen.width * 0.08, height: Screen.height * 0.1)
            }.frame(width: Screen.width * 0.08, height: Screen.height * 0.1)
            Text("\(Int(mazePromptViewModel.progress * 100))%")
                .customFont(.cherryBomb, size: 40)
                .foregroundColor(.text.darkBlue)
        }.padding()
    }
}

#Preview {
    MazeProgress()
}
