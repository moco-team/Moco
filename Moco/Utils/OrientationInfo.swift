//
//  OrientationInfo.swift
//  Moco
//
//  Created by Daniel Aprillio on 01/11/23.
//

import Foundation
import SwiftUI

class OrientationInfo: ObservableObject {
    enum Orientation {
        case portrait
        case landscapeLeft
        case landscapeRight
    }
    
    @Published var orientation: Orientation
    
    private var _observer: NSObjectProtocol?
    
    init() {
        // Start with default orientation
        self.orientation = .landscapeLeft
        
        // fairly arbitrary starting value for 'flat' orientations
        if UIDevice.current.orientation == .landscapeLeft {
            self.orientation = .landscapeLeft
        } else if UIDevice.current.orientation == .landscapeRight{
            self.orientation = .landscapeRight
        } else if UIDevice.current.orientation == .portrait {
            self.orientation = .portrait
        }
        
        // unowned self because we unregister before self becomes invalid
        _observer = NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: nil) { [unowned self] note in
            guard let device = note.object as? UIDevice else {
                return
            }
            if device.orientation == .portrait {
                self.orientation = .portrait
            } else if device.orientation == .landscapeLeft {
                self.orientation = .landscapeLeft
            } else if device.orientation == .landscapeRight {
                self.orientation = .landscapeRight
            }
        }
    }
    
    deinit {
        if let observer = _observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
