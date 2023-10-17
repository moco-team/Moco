//
//  LottieView.swift
//  Moco
//
//  Created by Daniel Aprillio on 17/10/23.
//

import Foundation
import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    var fileName: String
    var width: Double
    var height: Double
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> some UIView {
        
        let view = UIView(frame: .init(x:0, y:0, width: width, height: height))
        
        let lottieAnimationView = LottieAnimationView()
        let animation = LottieAnimation.named(fileName)
        
        lottieAnimationView.animation = animation
        lottieAnimationView.contentMode = .scaleAspectFit
        lottieAnimationView.loopMode = .loop
        lottieAnimationView.play()
        
        lottieAnimationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lottieAnimationView)
        
        NSLayoutConstraint.activate([
            lottieAnimationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            lottieAnimationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<LottieView>) {
        
    }
}
