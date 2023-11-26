//
//  MocoIcon.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 26/11/23.
//

import SwiftUI

struct MocoIcon: View {
    var width: CGFloat {
        UIDevice.isIPad ? 0.4 * Screen.width : 0.3 * Screen.width
    }

    var body: some View {
        Image("Story/nav-icon")
            .resizable()
            .scaledToFit()
            .frame(width: width)
            .padding(.top, Screen.height * 0.02)
    }
}

#Preview {
    MocoIcon()
}
