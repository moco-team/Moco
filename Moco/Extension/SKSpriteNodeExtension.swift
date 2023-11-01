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
            self.size = texture!.size()

            let verticalRatio = fillSize.height / self.texture!.size().height
            let horizontalRatio = fillSize.width /  self.texture!.size().width

            let scaleRatio = horizontalRatio < verticalRatio ? horizontalRatio : verticalRatio

            self.setScale(scaleRatio)
        }
    }

}
