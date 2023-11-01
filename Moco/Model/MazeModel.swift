//
//  MazeModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 26/10/23.
//

import Foundation

enum MoveDirection: Equatable {
    case left
    case right
    case up
    case down
}

struct MapSize: Equatable {
    var width: Int
    var height: Int
}

struct LocationPoint: Equatable {
    var xPos = 0
    var yPos = 0
}

struct MazeModel {
    var characterLocationPoint = LocationPoint()
    var correctPoint = LocationPoint()
    var startPoint = LocationPoint()
    var exitPoints = [LocationPoint()]

    static var mapSize = MapSize(width: 37, height: 25)

    var arrayPoint: [[Int]] = [[]]

    var points: [[CGPoint]] = Array(
        repeating: Array(
            repeating: CGPoint.zero, count: mapSize.width
        ), count: mapSize.height
    )

    init() {
        randomizeMaze()
    }

    mutating func randomizeMaze() {
        let newMazeWithPlayerPos = MazeModel.generateMaze(
            rows: MazeModel.mapSize.height,
            cols: MazeModel.mapSize.width
        )
        arrayPoint = newMazeWithPlayerPos.0
        characterLocationPoint = newMazeWithPlayerPos.1
        correctPoint = newMazeWithPlayerPos.2
        exitPoints = newMazeWithPlayerPos.3
        startPoint = characterLocationPoint
    }

    private static func generateMaze(rows: Int, cols: Int) -> ([[Int]], LocationPoint, LocationPoint, [LocationPoint]) {
        var maze = Array(repeating: Array(repeating: 1, count: cols), count: rows)

        func isValid(_ xPos: Int, _ yPos: Int) -> Bool {
            return xPos >= 0 && xPos < rows && yPos >= 0 && yPos < cols && maze[xPos][yPos] == 1
        }

        func recursiveBacktracking(xPos: Int, yPos: Int) {
            var directions = [(0, 2), (2, 0), (0, -2), (-2, 0)]
            directions.shuffle()
            for (dx, dy) in directions {
                let newX = xPos + dx
                let newY = yPos + dy
                if isValid(newX, newY) {
                    maze[newX][newY] = 0 // Mark the path (0)
                    maze[(xPos + newX) / 2][(yPos + newY) / 2] = 0 // Remove the wall
                    recursiveBacktracking(xPos: newX, yPos: newY)
                }
            }
        }

        func populateMaze() {
            maze = Array(repeating: Array(repeating: 1, count: cols), count: rows)
            var startX = Int.random(in: 1 ..< rows).advanced(by: 1) / 2 * 2 + 1
            var startY = Int.random(in: 1 ..< cols).advanced(by: 1) / 2 * 2 + 1
            while !maze.indices.contains(startX) || !maze.first!.indices.contains(startY) {
                startX = Int.random(in: 1 ..< rows).advanced(by: 1) / 2 * 2 + 1
                startY = Int.random(in: 1 ..< cols).advanced(by: 1) / 2 * 2 + 1
            }
            maze[startX][startY] = 0 // Mark the starting point
            recursiveBacktracking(xPos: startX, yPos: startY)
        }

        func isGoodMaze() -> Bool {
            var wallCount = 0
            maze[1].forEach { block in if block == 1 { wallCount += 1 }}
            return wallCount > 3
        }

        func populateGoodMaze() {
            populateMaze()

            while !isGoodMaze() {
                populateMaze()
            }
        }

        populateGoodMaze()

        func generateInOutXPoint(yPos: Int) -> LocationPoint {
            guard (maze[yPos].contains { $0 == 1 }) else { return LocationPoint() }

            var initX = Int.random(in: 1 ..< cols - 1)
            while maze[yPos][initX] == 0 ||
                (yPos == 0 && maze[yPos + 1][initX] == 1) ||
                (yPos == rows - 1 && maze[yPos - 1][initX] == 1) {
                initX = Int.random(in: 1 ..< cols - 1)
            }

            maze[yPos][initX] = 0
            return LocationPoint(xPos: initX, yPos: yPos)
        }

        func resetGenerateInOutPoint(exitOnly: Bool = false) {
            for col in 0 ..< cols {
                maze[0][col] = 1
                if !exitOnly {
                    maze[rows - 1][col] = 1
                }
            }
        }

        func checkDifferenceGreaterThan(_ array: [Int], diffCount: Int = 2) -> Bool {
            for index in 0 ..< (array.count - 1) {
                let difference = abs(array[index] - array[index + 1])
                if difference <= diffCount {
                    return false
                }
            }
            return true
        }

        func generateExitPoints() -> [LocationPoint] {
            var exitPositions = [
                generateInOutXPoint(yPos: 0),
                generateInOutXPoint(yPos: 0),
                generateInOutXPoint(yPos: 0)
            ]

            var xPositions = exitPositions.map { $0.xPos }.sorted()

            while !checkDifferenceGreaterThan(xPositions) {
                resetGenerateInOutPoint(exitOnly: true)
                exitPositions = [
                    generateInOutXPoint(yPos: 0),
                    generateInOutXPoint(yPos: 0),
                    generateInOutXPoint(yPos: 0)
                ]

                xPositions = exitPositions.map { $0.xPos }.sorted()
            }
            return exitPositions
        }

        var characterPos = generateInOutXPoint(yPos: rows - 1)
        var exitPoints = generateExitPoints()
        var correctPos = exitPoints.first!

        while !canReachDestination(from: maze, startRow: characterPos.yPos, startCol: characterPos.xPos, destinationRow: correctPos.yPos, destinationCol: correctPos.xPos) {
            resetGenerateInOutPoint()
            characterPos = generateInOutXPoint(yPos: rows - 1)
            correctPos = generateExitPoints().first!
        }

        return (maze, characterPos, correctPos, exitPoints)
    }

    private static func canReachDestination(from maze: [[Int]], startRow: Int, startCol: Int, destinationRow: Int, destinationCol: Int) -> Bool {
        let numRows = maze.count
        let numCols = maze[0].count
        var visited = Array(repeating: Array(repeating: false, count: numCols), count: numRows)

        func isValidMove(_ row: Int, _ col: Int) -> Bool {
            return row >= 0 && row < numRows && col >= 0 && col < numCols && maze[row][col] == 0 && !visited[row][col]
        }

        func dfs(_ row: Int, _ col: Int) -> Bool {
            if row == destinationRow && col == destinationCol {
                return true
            }

            visited[row][col] = true

            let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)] // Right, Left, Down, Up

            for (dr, dc) in directions {
                let newRow = row + dr
                let newCol = col + dc

                if isValidMove(newRow, newCol) && dfs(newRow, newCol) {
                    return true
                }
            }

            return false
        }

        return dfs(startRow, startCol)
    }

    mutating func move(_ direction: MoveDirection) -> Bool {
        switch direction {
        case .left:
            if characterLocationPoint.xPos <= 0 ||
                arrayPoint[characterLocationPoint.yPos][characterLocationPoint.xPos - 1] == 1 {
                return false
            }
            characterLocationPoint.xPos -= 1
        case .right:
            if characterLocationPoint.xPos >= MazeModel.mapSize.width - 1 ||
                arrayPoint[characterLocationPoint.yPos][characterLocationPoint.xPos + 1] == 1 {
                return false
            }
            characterLocationPoint.xPos += 1
        case .down:
            if characterLocationPoint.yPos >= MazeModel.mapSize.height - 1 ||
                arrayPoint[characterLocationPoint.yPos + 1][characterLocationPoint.xPos] == 1 {
                return false
            }
            characterLocationPoint.yPos += 1
        case .up:
            if characterLocationPoint.yPos <= 0 ||
                arrayPoint[characterLocationPoint.yPos - 1][characterLocationPoint.xPos] == 1 {
                return false
            }
            characterLocationPoint.yPos -= 1
        }
        guard
            points.indices.contains(characterLocationPoint.yPos) &&
            points.first!.indices.contains(characterLocationPoint.xPos)
        else { return false }

        return true
    }
}
