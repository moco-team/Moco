//
//  RootViewModifier.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 19/10/23.
//

import SwiftUI

struct RootViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .edgesIgnoringSafeArea(.all)
            .statusBar(hidden: true)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea()
    }
}

extension View {
    func rootViewModifier() -> some View {
        modifier(RootViewModifier())
    }
}
