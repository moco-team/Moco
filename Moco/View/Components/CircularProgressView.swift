//
//  CircularProgressView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 21/10/23.
//

import SwiftUI

struct CircularProgressView<Content: View>: View {
    let progress: Double
    var size: CGFloat = 200
    var color: Color = .green
    var width: CGFloat = 30

    @ViewBuilder let content: (Double) -> Content?

    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    color.opacity(0.5),
                    lineWidth: width
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    color,
                    style: StrokeStyle(
                        lineWidth: width,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                // 1
                .animation(.easeOut, value: progress)
            if let children = content(progress) {
                children
            }
        }.frame(width: size, height: size)
    }
}

#Preview {
    @State var progress: Double = 0.2

    return
        VStack {
            Spacer()
            CircularProgressView(progress: progress, size: 200) { progress in
                Text("\(progress * 100, specifier: "%.0f")")
                    .font(.largeTitle)
                    .bold()
            }
            Spacer()
            HStack {
                Slider(value: $progress, in: 0 ... 1)
            }
        }
}
