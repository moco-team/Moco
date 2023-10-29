//
//  TryMotionView.swift
//  Moco
//
//  Created by Daniel Aprillio on 29/10/23.
//

import SwiftUI

struct TryMotionView: View {
    
    @EnvironmentObject var motionViewModel: MotionViewModel
    @State private var roll = false
    @State private var pitch = false
    @State private var rollNum = 0.0
    @State private var pitchNum = 0.0
    
    func updateMotion() {
        rollNum = motionViewModel.getAttitude()?.roll ?? 0
        pitchNum = motionViewModel.getAttitude()?.pitch ?? 0
        roll = rollNum > 0
        pitch = pitchNum > 0
    }
    
    var body: some View {
        VStack{
           Text("Hello World!")
        }
        .onAppear {
            motionViewModel.startUpdates()
        }
        .onDisappear {
            motionViewModel.stopUpdates()
        }
    }
}

#Preview {
    TryMotionView()
}
