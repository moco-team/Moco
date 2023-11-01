//
//  SKSpriteNodeExtension.swift
//  Moco
//
//  Created by Daniel Aprillio on 01/11/23.
//

import Foundation
import SpriteKit

extension SKSpriteNode {
    func aspectFillToSize(fillSize: CGSize) {
        if texture != nil {
            size = texture!.size()

            let verticalRatio = fillSize.height / texture!.size().height
            let horizontalRatio = fillSize.width / texture!.size().width

            let scaleRatio = horizontalRatio < verticalRatio ? horizontalRatio : verticalRatio

            setScale(scaleRatio)
        }
    }
}
