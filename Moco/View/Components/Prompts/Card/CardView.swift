//
//  CardView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 13/11/23.
//

import SwiftUI

struct CardView: View {
    @State private var showPointer = false
    @State private var timerViewModel = TimerViewModel()
    var state = CardState.inactive
    var revealedImage = ""
    var text = ""
    var suffix = ""
    var type = CardType.character

    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    var onTap: (() -> Void)?

    func getWidth() -> CGFloat {
        switch type {
        case .character:
            return Screen.width * 0.25
        case .verb, .noun:
            return Screen.width * 0.12
        }
    }

    func getHeight() -> CGFloat {
        switch type {
        case .character:
            return 0.4 * Screen.height
        case .verb, .noun:
            return 0.2 * Screen.height
        }
    }

    func getActiveCard() -> String {
        switch type {
        case .character:
            return "Story/Prompts/card-active"
        case .verb:
            return "Story/Prompts/card-verb"
        case .noun:
            return "Story/Prompts/card-noun"
        }
    }

    var body: some View {
        VStack {
            switch state {
            case .active:
                VStack {
                    GeometryReader { proxy in
                        let frame = proxy.frame(in: .local)
                        Image(getActiveCard())
                            .resizable()
                            .scaledToFit()
                            .onTapGesture {
                                onTap?()
                            }
                            .scaleEffect(minScale: 1.0, maxScale: 1.05)
                            .pointer(
                                position: CGPoint(x: frame.midX, y: frame.midY),
                                isShowing: showPointer
                            )
                    }
                }
            case .inactive:
                Image("Story/Prompts/card-inactive")
                    .resizable()
                    .scaledToFit()
            case .revealed:
                if type == .character {
                    Image(revealedImage)
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .task {
            timerViewModel.startTimer(key: text, withInterval: 5) {
                showPointer = true
            }
        }
        .onDisappear {
            timerViewModel.stopTimer(text)
        }
        .frame(
            width: getWidth(),
            height: getHeight()
        )
    }
}

#Preview {
    CardView()
}
