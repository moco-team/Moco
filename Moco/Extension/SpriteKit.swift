//
//  SpriteKit.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 30/10/23.
//

import SpriteKit

extension SKNode {
    func actionForKeyIsRunning(key: String) -> Bool {
        action(forKey: key) != nil
    }
}
