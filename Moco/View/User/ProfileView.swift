//
//  ProfileView.swift
//  Moco
//
//  Created by Daniel Aprillio on 20/10/23.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.navigate) private var navigate

    var body: some View {
        Button("Profile View") {
            navigate.pop(2)
        }
    }
}

#Preview {
    ProfileView()
}
