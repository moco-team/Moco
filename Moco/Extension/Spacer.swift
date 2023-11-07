//
//  Spacer.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 30/10/23.
//

import SwiftUI

public extension Spacer {
    func onTapGesture(count: Int = 1,
                      perform action: @escaping () -> Void) -> some View {
        ZStack {
            Color.black.opacity(0.001)
                .onTapGesture(count: count, perform: action)
            self
        }
    }

    func onLongPressGesture(minimumDuration: Double = 0.5,
                            maximumDistance: CGFloat = 10,
                            perform action: @escaping () -> Void,
                            onPressingChanged onChangeAction: ((Bool) -> Void)? = nil) -> some View {
        ZStack {
            Color.black.opacity(0.001)
                .onLongPressGesture(minimumDuration: minimumDuration,
                                    maximumDistance: maximumDistance,
                                    perform: action,
                                    onPressingChanged: onChangeAction)
            self
        }
    }
}
