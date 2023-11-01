//
//  MazeScene.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 25/10/23.
//

import SpriteKit
import SwiftUI

class MazeScene: SKScene, ObservableObject {
    var moco: SKSpriteNode!
    var touched: Bool = false
    var score: Int = 0

    @Published private(set) var correctAnswer = false

    var mazeModel = MazeModel()

    override func didMove(to _: SKView) {
        createMap()
        createPlayer()
    }

    func createMap() {
        let screenWidth = size.width
        let screenHeight = size.height
        let tileSize = min(screenWidth, screenHeight) / CGFloat(mazeModel.arrayPoint.count)

        var xRenderPos: CGFloat
        var yRenderPos: CGFloat = screenHeight
        for index in 0 ..< mazeModel.arrayPoint.count {
            xRenderPos = tileSize / 2 + screenWidth / 2
            xRenderPos -= (tileSize * CGFloat(mazeModel.arrayPoint.first!.count)) / 2

            if index == 0 {
                yRenderPos = screenHeight - tileSize / 2
            } else {
                yRenderPos -= tileSize
            }

            for jIndex in 0 ..< mazeModel.arrayPoint[index].count {
                let ground = SKSpriteNode()
                ground.size = CGSize(width: tileSize, height: tileSize)

                if mazeModel.arrayPoint[index][jIndex] == 0 {
                    ground.name = "0"
                    ground.texture = SKTexture(imageNamed: "Maze/floor")
                } else if mazeModel.arrayPoint[index][jIndex] == 1 {
                    ground.name = "1"
                    ground.texture = SKTexture(imageNamed: "Maze/wall")
                }

                ground.position = CGPoint(x: xRenderPos, y: yRenderPos)
                xRenderPos += tileSize
                addChild(ground)
                mazeModel.points[index][jIndex] = ground.position
            }
        }
    }

    func move(_ direction: MoveDirection) {
        guard !moco.actionForKeyIsRunning(key: "moving") else { return }
        guard mazeModel.move(direction) else { return }

        let position =
            mazeModel.points[mazeModel.characterLocationPoint.yPos][mazeModel.characterLocationPoint.xPos]

        if mazeModel.characterLocationPoint.yPos == 0 && mazeModel.characterLocationPoint.xPos != mazeModel.correctPoint.xPos {
            let move = SKAction.move(to: position, duration: 0.3)
            let scale = SKAction.scale(to: 0.0001, duration: 0.3)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([move, scale, remove])
            moco.run(sequence) { [unowned self] in
                createPlayer()
            }
        } else if mazeModel.characterLocationPoint == mazeModel.correctPoint {
            correctAnswer = true
        }

        let move = SKAction.move(to: position, duration: 0.3)
        let sequence = SKAction.sequence([move])
        moco.run(sequence, withKey: "moving")
    }

    func createPlayer() {
        moco = SKSpriteNode(
            texture: SKTexture(imageNamed: "Maze/moco-head"),
            size: CGSize(
                width: min(size.width, size.height) / CGFloat(mazeModel.arrayPoint.count),
                height: min(size.width, size.height) / CGFloat(mazeModel.arrayPoint.count)
            )
        )

        moco.name = "moco"
        mazeModel.characterLocationPoint = mazeModel.startPoint
        moco.position =
            mazeModel.points[mazeModel.startPoint.yPos][mazeModel.startPoint.xPos]
        addChild(moco)
    }

    func actionMovePlayer(to: SKNode, xPos: CGFloat, yPos: CGFloat) {
        let move = SKAction.move(to: to.position, duration: 0.15)
        let void = SKAction.run { [self] in
            movePacman(xPos: xPos, yPos: yPos)
        }
        let sequence = SKAction.sequence([move, void])
        moco.run(sequence)
    }

    func movePacman(xPos: CGFloat, yPos: CGFloat) {
        let next = nodes(at: CGPoint(x: moco.position.x + xPos, y: moco.position.y + yPos)).last
        if next?.name == "0" {
            if let nextChildNode = next?.childNode(withName: "0") {
                nextChildNode.removeFromParent()
            }
            actionMovePlayer(to: next!, xPos: xPos, yPos: yPos)
        }
    }

    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
//        let touch = touches.first!
//        let location = touch.location(in: self)
//        if atPoint(location).name == "left" {
//            touched = true
//            childNode(withName: "left")?.alpha = 1
//            movePacman(x: -size.width / CGFloat(arrayPoint.count), y: 0)
//        }
//        if atPoint(location).name == "right" {
//            touched = true
//            childNode(withName: "right")?.alpha = 1
//            movePacman(x: size.width / CGFloat(arrayPoint.count), y: 0)
//        }
//        if atPoint(location).name == "up" {
//            touched = true
//            childNode(withName: "up")?.alpha = 1
//            movePacman(x: 0, y: size.width / CGFloat(arrayPoint.count))
//        }
//        if atPoint(location).name == "down" {
//            touched = true
//            childNode(withName: "down")?.alpha = 1
//            movePacman(x: 0, y: -size.width / CGFloat(arrayPoint.count))
//        }
    }

    override func touchesEnded(_: Set<UITouch>, with _: UIEvent?) {
//        for child in children {
//            if child.name == "left" || child.name == "right" || child.name == "up" || child.name == "down" {
//                child.alpha = 0.5
//            }
//        }
//        touched = false
    }
}

#Preview {
    MazeView()
}
