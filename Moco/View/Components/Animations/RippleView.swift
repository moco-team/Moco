//
//  RippleView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 24/10/23.
//

import SwiftUI

struct Ripple: Identifiable, Hashable {
    var id = UUID()
    var xPosition: CGFloat
    var yPosition: CGFloat
}

struct RippleView: View {
    @State private var isVisible = true
    var xPosition: CGFloat?
    var yPosition: CGFloat?

    @State var index = 0
    let images = (0 ... 60).map { UIImage(named: "Ripple_\($0)")! }
    let timer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect()

    var doneHandler: (() -> Void)?

    var body: some View {
        VStack {
            if isVisible {
                VStack {
                    if let xPos = xPosition, let yPos = yPosition {
                        Image(uiImage: images[index])
                            .resizable()
                            .frame(width: 200, height: 200, alignment: .center)
                            .onReceive(timer) { _ in
                                self.index += 1
                                if self.index >= 60 { self.index = 0 }
                            }
                            .position(x: xPos, y: yPos)
                    } else {
                        Image(uiImage: images[index])
                            .resizable()
                            .frame(width: 200, height: 200, alignment: .center)
                            .onReceive(timer) { _ in
                                self.index += 1
                                if self.index >= 60 { self.index = 0 }
                            }
                    }
                }.onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                        self.index = 0
                        self.isVisible = false
                        doneHandler?()
                    }
                })
            }
        }
    }
}

// TODO: - Preview them ripples
#Preview {
    EmptyView()
}
