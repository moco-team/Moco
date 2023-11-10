//
//  MazeScene.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 25/10/23.
//

import SpriteKit
import SwiftUI

@propertyWrapper
struct MazeAnswerAssets {
    private var answerAssets: [String] = []
    var wrappedValue: [String] {
        get { return answerAssets }
        // ???: Maximum 2 answers
        set { answerAssets = Array(newValue.prefix(2)) }
    }

    init(wrappedValue: [String]) {
        answerAssets = Array(wrappedValue.prefix(2))
    }
}

class MazeScene: SKScene, ObservableObject {
    var moco: SKSpriteNode!
    var obj01: SKSpriteNode!
    var obj02: SKSpriteNode!
    var obj03: SKSpriteNode!

    var touched: Bool = false
    var score: Int = 0

    @MazeAnswerAssets var wrongAnswerAsset = ["Maze/answer_one", "Maze/answer_two"] {
        didSet {
            reloadObjectiveTexture()
        }
    }

    var correctAnswerAsset = "Maze/answer_three" {
        didSet {
            reloadObjectiveTexture()
        }
    }

    @Published private(set) var correctAnswer: Bool?
    @Published private(set) var wrongAnswer: Bool?

    var mazeModel = MazeModel()

    override func didMove(to _: SKView) {
        createMap()
        createPlayer()
        createObjective()
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
        guard moco != nil && !moco.actionForKeyIsRunning(key: "moving") else { return }
        guard mazeModel.move(direction) else { return }

        let position =
            mazeModel.points[mazeModel.characterLocationPoint.yPos][mazeModel.characterLocationPoint.xPos]

        let move = SKAction.move(to: position, duration: 0.3)
        let sequence = SKAction.sequence([move])
        moco.run(sequence, withKey: "moving")

        if mazeModel.characterLocationPoint.yPos == mazeModel.correctPoint.yPos &&
            mazeModel.characterLocationPoint.xPos != mazeModel.correctPoint.xPos {
//            let move = SKAction.move(to: position, duration: 0.3)
//            let scale = SKAction.scale(to: 0.0001, duration: 0.3)
//            let remove = SKAction.removeFromParent()
//            let sequence = SKAction.sequence([move, scale, remove])
//            moco.run(sequence) { [unowned self] in
//                createPlayer()
//            }
            print("char", mazeModel.characterLocationPoint, "goal", mazeModel.correctPoint)
            correctAnswer = false
            wrongAnswer = true
        } else if mazeModel.characterLocationPoint == mazeModel.correctPoint {
            print("char", mazeModel.characterLocationPoint, "goal", mazeModel.correctPoint)
            correctAnswer = true
            wrongAnswer = false
        } else {
            correctAnswer = nil
            wrongAnswer = nil
        }
    }

    func createPlayer() {
        moco = SKSpriteNode(
            texture: SKTexture(imageNamed: "Maze/moco-head"),
            size: CGSize(
                width: min(size.width, size.height) / CGFloat(mazeModel.arrayPoint.count),
                height: min(size.width, size.height) / CGFloat(mazeModel.arrayPoint.count)
            )
        )

        correctAnswer = nil
        wrongAnswer = nil

        moco.name = "moco"
        mazeModel.resetPlayerLocation()
        moco.position =
            mazeModel.points[mazeModel.startPoint.yPos][mazeModel.startPoint.xPos]
        addChild(moco)
    }

    func createObjective() {
        obj01 = SKSpriteNode(texture: SKTexture(imageNamed: correctAnswerAsset))
        obj01.aspectFillToSize(fillSize: CGSize(
            width: min(size.width, size.height) / CGFloat(mazeModel.arrayPoint.count),
            height: min(size.width, size.height) / CGFloat(mazeModel.arrayPoint.count)
        )
        )
        obj02 = SKSpriteNode(texture: SKTexture(imageNamed: wrongAnswerAsset[0]))
        obj02.aspectFillToSize(fillSize: CGSize(
            width: min(size.width, size.height) / CGFloat(mazeModel.arrayPoint.count),
            height: min(size.width, size.height) / CGFloat(mazeModel.arrayPoint.count)
        )
        )
        obj03 = SKSpriteNode(texture: SKTexture(imageNamed: wrongAnswerAsset[1]))
        obj03.aspectFillToSize(fillSize: CGSize(
            width: min(size.width, size.height) / CGFloat(mazeModel.arrayPoint.count),
            height: min(size.width, size.height) / CGFloat(mazeModel.arrayPoint.count)
        )
        )

        obj01.name = "obj01"
        obj01.position =
            mazeModel.points[mazeModel.exitPoints[0].yPos][mazeModel.exitPoints[0].xPos]
        addChild(obj01)

        obj02.name = "obj02"
        obj02.position =
            mazeModel.points[mazeModel.exitPoints[1].yPos][mazeModel.exitPoints[1].xPos]
        addChild(obj02)

        obj03.name = "obj03"
        obj03.position =
            mazeModel.points[mazeModel.exitPoints[2].yPos][mazeModel.exitPoints[2].xPos]
        addChild(obj03)
    }

    func reloadObjectiveTexture() {
        obj01?.texture = SKTexture(imageNamed: correctAnswerAsset)
        obj02?.texture = SKTexture(imageNamed: wrongAnswerAsset[0])
        obj03?.texture = SKTexture(imageNamed: wrongAnswerAsset[1])
    }

    // MARK: - Not used

    /*
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
     */
}

#Preview {
    MazeView(correctAnswer: .constant(false), wrongAnswer: .constant(true))
}
