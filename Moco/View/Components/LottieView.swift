//
//  LottieView.swift
//  Moco
//
//  Created by Daniel Aprillio on 17/10/23.
//

import Foundation
import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
    var fileName: String
    var width: Double = 0
    var height: Double = 0
    var loopMode: LottieLoopMode = .playOnce
    var contentMode: UIView.ContentMode = .scaleAspectFit

    func makeUIView(context _: UIViewRepresentableContext<LottieView>) -> some UIView {
        let view = UIView(frame: .init(x: 0, y: 0, width: width, height: height))

        let lottieAnimationView = LottieAnimationView()
        let animation = LottieAnimation.named(fileName)

        lottieAnimationView.animation = animation
        lottieAnimationView.contentMode = contentMode
        lottieAnimationView.loopMode = loopMode
        lottieAnimationView.play()

        lottieAnimationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lottieAnimationView)

        NSLayoutConstraint.activate([
            lottieAnimationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            lottieAnimationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            lottieAnimationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lottieAnimationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        return view
    }

    func updateUIView(_: UIViewType, context _: UIViewRepresentableContext<LottieView>) {}
}

#Preview {
    LottieView(fileName: "testing-cat.json")
}
