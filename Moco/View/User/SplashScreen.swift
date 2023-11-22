//
//  SplashScreen.swift
//  Moco
//
//  Created by Daniel Aprillio on 22/11/23.
//

import SwiftUI

struct SplashScreen: View {
    
    @State private var scale = 0.6
    @Binding var isActive: Bool
    
    var body: some View {
        ZStack{
            RadialGradient(colors: [Color(hex: "5EB9FF"), Color(hex:"6892B8")], center: .center, startRadius: Screen.width * 0.05, endRadius: Screen.width * 0.55)
            VStack {
                VStack {
                    Image("moco_logo_transparent")
                        .resizable()
                        .scaledToFit()
                        .frame(width: Screen.width * 0.55)
                        .foregroundColor(.blue)
                }.scaleEffect(scale)
                    .onAppear{
                        withAnimation(.easeIn(duration: 0.8)) {
                            self.scale = 0.9
                        }
                    }
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }.ignoresSafeArea()
    }
}

#Preview {
    SplashScreen(isActive: .constant(true))
}
