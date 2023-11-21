//
//  ViewOnLoad.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 30/10/23.
//

import SwiftUI

private struct ViewOnLoadModifier: ViewModifier {
    @State private var didLoad = false

    var async = false
    private let action: (() -> Void)?

    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }

    init(async: Bool, perform action: (() -> Void)? = nil) {
        self.action = action
        self.async = async
    }

    func body(content: Content) -> some View {
        content
            .onAppear {
                guard !didLoad && !async
                else {
                    return
                }

                didLoad = true
                action?()
            }
            .task {
                guard !didLoad && async
                else {
                    return
                }

                didLoad = true
                action?()
            }
    }
}

public extension View {
    func onLoad(async: Bool = false, perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewOnLoadModifier(async: async, perform: action))
    }
}
