//
//  InvisibleButton.swift
//  Moco
//
//  Created by Carissa Farry Hilmi Az Zahra on 19/10/23.
//

import SwiftUI

struct InvisibleButton: View {
    let action: (() -> Void)?

    var body: some View {
        Color.clear
            .contentShape(Rectangle())
            .onTapGesture {
                action?()
            }
    }
}

#Preview {
    InvisibleButton(action: {})
}
