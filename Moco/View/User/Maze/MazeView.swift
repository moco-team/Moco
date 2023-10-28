//
//  MazeView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 25/10/23.
//

import SpriteKit
import SwiftUI

struct MazeView: View {
    let scene: MazeScene = {
        let screenWidth = Screen.width
        let screenHeight = Screen.height
        let scene = MazeScene(
            size: CGSize(width: screenWidth, height: screenHeight)
        )
        scene.scaleMode = .fill
        print(screenWidth, screenHeight)

        return scene
    }()

    var body: some View {
        ZStack {
            SpriteView(scene: scene, options: [.allowsTransparency])
                .frame(width: Screen.width, height: Screen.height)
                .edgesIgnoringSafeArea(.all)
                .statusBar(hidden: true)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .ignoresSafeArea()
            VStack {
                Button("left") {
                    scene.move(.left)
                }
                Button("right") {
                    scene.move(.right)
                }
                Button("up") {
                    scene.move(.up)
                }
                Button("down") {
                    scene.move(.down)
                }
            }
        }.background(.ultraThinMaterial)
    }
}

#Preview {
    MazeView()
}
