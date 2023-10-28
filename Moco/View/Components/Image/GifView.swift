//
//  GifView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 27/10/23.
//

import FLAnimatedImage
import SwiftUI

struct GIFView: UIViewRepresentable {
    private var type: URLType

    init(type: URLType) {
        self.type = type
    }

    private let imageView: FLAnimatedImageView = {
        let imageView = FLAnimatedImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
}

extension GIFView {
    func makeUIView(context _: Context) -> UIView {
        let view = UIView(frame: .zero)

        view.addSubview(activityIndicator)
        view.addSubview(imageView)

        imageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        return view
    }

    func updateUIView(_: UIView, context _: Context) {
        activityIndicator.startAnimating()
        guard let url = type.url else { return }

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                let image = FLAnimatedImage(animatedGIFData: data)

                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    imageView.animatedImage = image
                }
            }
        }
    }
}

#Preview {
    GIFView(
        type: .url(
            URL(
                string: "https://i.pinimg.com/originals/e3/8b/75/e38b75f9ceb27f5f032f5656158dde55.gif")!
        )
    )
    .frame(width: 200, height: 200)
    .padding(.horizontal)
    .padding(.top, -75)
    .frame(width: 280, alignment: .center)
}
