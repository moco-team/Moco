//
//  MazeScene.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 25/10/23.
//

import SpriteKit
import SwiftUI

enum CollisionTypes: UInt32 {
    case player = 1
    case wall = 2
    case finish = 4
}

enum FinishType: String {
    case wrong
    case correct
}

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

class MazeScene: SKScene, SKPhysicsContactDelegate, ObservableObject {
    let motionViewModel = MotionViewModel.shared

    var moco: SKSpriteNode!
    var obj01: SKSpriteNode!
    var obj02: SKSpriteNode!
    var obj03: SKSpriteNode!

    var lastTouchPosition: CGPoint?

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
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
        createMap()
        createPlayer()
        createObjective()
        motionViewModel.startUpdates()
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
            correctAnswer = false
            wrongAnswer = true
        } else if mazeModel.characterLocationPoint == mazeModel.correctPoint {
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

        moco.physicsBody = SKPhysicsBody(circleOfRadius: (moco.size.width * 0.9) / 2)
        moco.physicsBody?.allowsRotation = false
        moco.physicsBody?.linearDamping = 0.5

        moco.physicsBody?.categoryBitMask = CollisionTypes.player.rawValue
        moco.physicsBody?.contactTestBitMask = CollisionTypes.finish.rawValue
        moco.physicsBody?.collisionBitMask = CollisionTypes.wall.rawValue

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
        obj01.alpha = 0
        obj02.alpha = 0
        obj03.alpha = 0

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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            lastTouchPosition = location
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            lastTouchPosition = location
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchPosition = nil
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastTouchPosition = nil
    }

    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node == moco {
            playerCollided(with: contact.bodyB.node!)
        } else if contact.bodyB.node == moco {
            playerCollided(with: contact.bodyA.node!)
        }
    }

    func playerCollided(with node: SKNode) {
        if node.name == FinishType.correct.rawValue {
            correctAnswer = true
            wrongAnswer = false
        } else if node.name == FinishType.wrong.rawValue {
            correctAnswer = false
            wrongAnswer = true
        }
    }

    override func update(_ currentTime: TimeInterval) {
#if targetEnvironment(simulator)
        if let currentTouch = lastTouchPosition {
            let diff = CGPoint(x: currentTouch.x - player.position.x, y: currentTouch.y - player.position.y)
            physicsWorld.gravity = CGVector(dx: diff.x / 100, dy: diff.y / 100)
        }
#else
        if let accelerometerData = motionViewModel.accelerometerData {
            physicsWorld.gravity = CGVector(
                dx: accelerometerData.acceleration.y * -2,
                dy: accelerometerData.acceleration.x * 2
            )
        }
#endif
    }
}

extension MazeScene {
    func createMap() {
        let screenWidth = size.width
        let screenHeight = size.height
        let tileSize = min(screenWidth, screenHeight) / CGFloat(mazeModel.arrayPoint.count)

        var xRenderPos: CGFloat
        var yRenderPos: CGFloat = screenHeight
        for index in mazeModel.arrayPoint.indices {
            xRenderPos = tileSize / 2 + screenWidth / 2
            xRenderPos -= (tileSize * CGFloat(mazeModel.arrayPoint.first!.count)) / 2

            if index == 0 {
                yRenderPos = screenHeight - tileSize / 2
            } else {
                yRenderPos -= tileSize
            }

            for jIndex in mazeModel.arrayPoint[index].indices {
                let ground = SKSpriteNode()
                ground.size = CGSize(width: tileSize, height: tileSize)

                if mazeModel.arrayPoint[index][jIndex] == 0 {
                    ground.name = "0"
                    ground.texture = SKTexture(imageNamed: "Maze/floor")
                    if index == mazeModel.arrayPoint.indices.last { // last tile
                        ground.name = FinishType.wrong.rawValue
                        if jIndex == mazeModel.correctPoint.xPos {
                            ground.name = FinishType.correct.rawValue
                        }
                        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(
                            width: ground.size.width * 0.5,
                            height: ground.size.height * 0.5)
                        )
                        ground.physicsBody?.categoryBitMask = CollisionTypes.finish.rawValue
                        ground.physicsBody?.contactTestBitMask = CollisionTypes.player.rawValue
                        ground.physicsBody?.isDynamic = false
                        ground.physicsBody?.collisionBitMask = 0
                    }
                } else if mazeModel.arrayPoint[index][jIndex] == 1 {
                    ground.name = "1"
                    ground.texture = SKTexture(imageNamed: "Maze/wall")
                    ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
                    ground.physicsBody?.categoryBitMask = CollisionTypes.wall.rawValue
                    ground.physicsBody?.isDynamic = false
                }

                // MARK: - Outer wall

                if mazeModel.arrayPoint[index][jIndex] == 0 &&
                    [0, mazeModel.arrayPoint.indices.last].contains(index) {
                    let outerWall = SKSpriteNode()
                    outerWall.size = CGSize(width: tileSize, height: tileSize)
                    outerWall.name = "outer_wall"
                    outerWall.texture = SKTexture(imageNamed: "Maze/wall")
                    outerWall.alpha = 0
                    outerWall.physicsBody = SKPhysicsBody(rectangleOf: outerWall.size)
                    outerWall.physicsBody?.categoryBitMask = CollisionTypes.wall.rawValue
                    outerWall.physicsBody?.isDynamic = false
                    outerWall.position = CGPoint(
                        x: xRenderPos,
                        y: yRenderPos + (index == 0 ? tileSize : -tileSize)
                    )
                    addChild(outerWall)
                }

                ground.position = CGPoint(x: xRenderPos, y: yRenderPos)
                xRenderPos += tileSize
                addChild(ground)
                mazeModel.points[index][jIndex] = ground.position
            }
        }
    }
}

#Preview {
    MazeView()
}
