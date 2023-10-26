//
//  MazeScene.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 25/10/23.
//

import SpriteKit

class MazeScene: SKScene {
    var moco: SKSpriteNode!
    var touched: Bool = false
    var snack1: SKSpriteNode!
    var score: Int = 0

    var mazeModel = MazeModel()

    override func didMove(to _: SKView) {
        createMap()
        createPacman()
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
                    let food = SKSpriteNode(
                        color: UIColor(red: 0.36, green: 0.25, blue: 0.20, alpha: 1.00),
                        size: CGSize(width: 6, height: 6)
                    )
                    food.name = "0"
                    ground.name = "0"
                    ground.color = UIColor(red: 0.77, green: 0.87, blue: 0.96, alpha: 1.00)
                    ground.addChild(food)
                } else if mazeModel.arrayPoint[index][jIndex] == 1 {
                    ground.name = "1"
                    ground.texture = SKTexture(imageNamed: "wall")
                }

                ground.position = CGPoint(x: xRenderPos, y: yRenderPos)
                xRenderPos += tileSize
                addChild(ground)
                mazeModel.points[index][jIndex] = ground.position
            }
        }
    }

    func move(_ direction: MoveDirection) {
        guard mazeModel.move(direction) else { return }

        let position =
            mazeModel.points[mazeModel.characterLocationPoint.yPos][mazeModel.characterLocationPoint.xPos]

        let move = SKAction.move(to: position, duration: 0.15)
        let sequence = SKAction.sequence([move])
        moco.run(sequence)
    }

    func createPacman() {
        moco = SKSpriteNode(
            texture: SKTexture(imageNamed: "turtle"),
            size: CGSize(
                width: min(size.width, size.height) / CGFloat(mazeModel.arrayPoint.count),
                height: min(size.width, size.height) / CGFloat(mazeModel.arrayPoint.count)
            )
        )
        moco.name = "pacman"
        moco.position =
            mazeModel.points[mazeModel.characterLocationPoint.yPos][mazeModel.characterLocationPoint.xPos]
        addChild(moco)
    }

    func actionMovePacman(to: SKNode, xPos: CGFloat, yPos: CGFloat) {
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
            actionMovePacman(to: next!, xPos: xPos, yPos: yPos)
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
