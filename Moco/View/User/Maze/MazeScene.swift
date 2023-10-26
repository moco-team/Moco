//
//  MazeScene.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 25/10/23.
//

import SpriteKit

enum MoveDirection {
    case left
    case right
    case up
    case down
}

struct MapSize {
    var width: Int
    var height: Int
}

class MazeScene: SKScene {
    var pacman: SKSpriteNode!
    var touched: Bool = false
    var snack1: SKSpriteNode!
    var score: Int = 0
    var characterLocationPoint = (25, 19)

    static var mapSize = MapSize(width: 21, height: 27)

    var arrayPoint: [[Int]] =
        [
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
            [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 0, 1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1],
            [1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 1, 0, 1],
            [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1],
            [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1],
            [1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1],
            [1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1],
            [1, 1, 1, 1, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1],
            [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1],
            [1, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1],
            [1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1],
            [1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1],
            [1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1],
            [1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1],
            [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1],
            [1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1],
            [1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1],
            [1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1],
            [1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1],
            [1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
        ]

    var points: [[CGPoint]] = Array(repeating: Array(repeating: CGPoint.zero, count: mapSize.width), count: mapSize.height)

    override func didMove(to _: SKView) {
        createMap()
        createPacman()
    }

    func createMap() {
        let screenWidth = size.width
        let screenHeight = size.height
        let tileSize = min(screenWidth, screenHeight) / CGFloat(arrayPoint.count)

        var x: CGFloat
        var y: CGFloat = screenHeight
        for i in 0 ..< arrayPoint.count {
            x = tileSize / 2 + screenWidth / 2
            x -= (tileSize * CGFloat(arrayPoint.first!.count)) / 2

            if i == 0 {
                y = screenHeight - tileSize / 2
            } else {
                y -= tileSize
            }

            for j in 0 ..< arrayPoint[i].count {
                let ground = SKSpriteNode()
                ground.size = CGSize(width: tileSize, height: tileSize)

                if arrayPoint[i][j] == 0 {
                    let food = SKSpriteNode(color: UIColor(red: 0.36, green: 0.25, blue: 0.20, alpha: 1.00), size: CGSize(width: 6, height: 6))
                    food.name = "0"
                    ground.name = "0"
                    ground.color = UIColor(red: 0.77, green: 0.87, blue: 0.96, alpha: 1.00)
                    ground.addChild(food)
                } else if arrayPoint[i][j] == 1 {
                    ground.name = "1"
                    ground.texture = SKTexture(imageNamed: "wall")
                }

                ground.position = CGPoint(x: x, y: y)
                x += tileSize
                addChild(ground)
                points[i][j] = ground.position
            }
        }
    }

    func move(_ direction: MoveDirection) {
        switch direction {
        case .left:
            if characterLocationPoint.1 <= 0 ||
                arrayPoint[characterLocationPoint.0][characterLocationPoint.1 - 1] == 1 {
                return
            }
            characterLocationPoint.1 -= 1
        case .right:
            if characterLocationPoint.1 >= MazeScene.mapSize.width - 1 ||
                arrayPoint[characterLocationPoint.0][characterLocationPoint.1 + 1] == 1 {
                return
            }
            characterLocationPoint.1 += 1
        case .down:
            if characterLocationPoint.0 >= MazeScene.mapSize.height - 1 ||
                arrayPoint[characterLocationPoint.0 + 1][characterLocationPoint.1] == 1 {
                return
            }
            characterLocationPoint.0 += 1
        case .up:
            if characterLocationPoint.0 <= 0 ||
                arrayPoint[characterLocationPoint.0 - 1][characterLocationPoint.1] == 1 {
                return
            }
            characterLocationPoint.0 -= 1
        }
        guard
            points.indices.contains(characterLocationPoint.0) &&
            points.first!.indices.contains(characterLocationPoint.1)
        else { return }

        let position = points[characterLocationPoint.0][characterLocationPoint.1]

        let move = SKAction.move(to: position, duration: 0.15)
        let sequence = SKAction.sequence([move])
        pacman.run(sequence)
    }

    func createPacman() {
        pacman = SKSpriteNode(texture: SKTexture(imageNamed: "turtle"), size: CGSize(width: min(size.width, size.height) / CGFloat(arrayPoint.count), height: min(size.width, size.height) / CGFloat(arrayPoint.count)))
        pacman.name = "pacman"
        pacman.position = points[25][19]
        addChild(pacman)
    }

    func actionMovePacman(to: SKNode, x: CGFloat, y: CGFloat) {
        let move = SKAction.move(to: to.position, duration: 0.15)
        let void = SKAction.run { [self] in
            movePacman(x: x, y: y)
        }
        let sequence = SKAction.sequence([move, void])
        pacman.run(sequence)
    }

    func movePacman(x: CGFloat, y: CGFloat) {
        let next = nodes(at: CGPoint(x: pacman.position.x + x, y: pacman.position.y + y)).last
        if next?.name == "0" {
            if let nextChildNode = next?.childNode(withName: "0") {
                nextChildNode.removeFromParent()
            }
            actionMovePacman(to: next!, x: x, y: y)
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
