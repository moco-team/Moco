//
//  CustomAsyncImage.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 21/10/23.
//

import SwiftUI

struct CustomAsyncImage: View {
    var url: String
    var aspectRatio: ContentMode = .fit

    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case let .success(image):
                image.resizable()
                    .aspectRatio(contentMode: aspectRatio)
            case .failure:
                Image(systemName: "photo")
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    CustomAsyncImage(url: "https://mocoapp.sirv.com/moco/cover/story-1/cover.png").frame(width: 200, height: 200)
}
