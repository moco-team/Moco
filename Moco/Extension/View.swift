//
//  View.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 30/10/23.
//

import SwiftUI

extension View {
    // MARK: Vertical Center

    func vCenter() -> some View {
        frame(maxHeight: .infinity, alignment: .center)
    }

    // MARK: Vertical Top

    func vTop() -> some View {
        frame(maxHeight: .infinity, alignment: .top)
    }

    // MARK: Vertical Bottom

    func vBottom() -> some View {
        frame(maxHeight: .infinity, alignment: .bottom)
    }

    // MARK: Horizontal Center

    func hCenter() -> some View {
        frame(maxWidth: .infinity, alignment: .center)
    }

    // MARK: Horizontal Leading

    func hLeading() -> some View {
        frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: Horizontal Trailing

    func hTrailing() -> some View {
        frame(maxWidth: .infinity, alignment: .trailing)
    }
}

// Our custom view modifier to track rotation and
// call our action
struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

// A View wrapper to make the modifier easier to use
extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        modifier(DeviceRotationViewModifier(action: action))
    }
}

extension View {
    @ViewBuilder
    func forceRotation(_ orientation: UIInterfaceOrientationMask? = nil) -> some View {
        onAppear {
            AppDelegate.orientationLock = orientation ?? (Screen.orientation == .landscapeLeft ? .landscapeLeft : .landscapeRight)
        }
        onDisappear {
            AppDelegate.orientationLock = nil
        }
    }
}
