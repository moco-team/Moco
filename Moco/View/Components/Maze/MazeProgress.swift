//
//  MazeProgress.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 07/11/23.
//

import SwiftUI

struct MazeProgress: View {
    @Binding var progress: Double

    var body: some View {
        GeometryReader {
            let size = $0.size
            ZStack {
                Image("Maze/moco-head").resizable().aspectRatio(contentMode: .fit)
                Color.gray
                    .offset(y: -size.height * progress)
                    .mask {
                        Image("Maze/moco-head").resizable().aspectRatio(contentMode: .fit)
                    }
            }.frame(width: Screen.width * 0.1, height: Screen.height * 0.1)
        }.frame(width: Screen.width * 0.1, height: Screen.height * 0.1)
    }
}

#Preview {
    MazeProgress(progress: .constant(0.5))
}
