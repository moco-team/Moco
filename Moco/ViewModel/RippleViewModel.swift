//
//  RippleViewModel.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 24/10/23.
//

import Foundation

@Observable class RippleViewModel {
    private var rippleModel = RippleModel()

    var ripples: [Ripple] {
        get {
            rippleModel.ripples
        }
        set {
            rippleModel.ripples = newValue
        }
    }

    var isVisible: Bool {
        get {
            rippleModel.isRippleVisible
        }
        set {
            rippleModel.isRippleVisible = newValue
        }
    }

    func appendRipple(_ newRipple: Ripple) {
        rippleModel.ripples.append(newRipple)
    }

    func removeRipple(id: String) {
        rippleModel.ripples = ripples.filter {
            $0.id.uuidString != id
        }
    }
}
