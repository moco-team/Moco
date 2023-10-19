//
//  Storm.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 18/10/23.
//

import SwiftUI

struct Raindrop: Hashable, Equatable {
    var xPosition: Double
    var removalDate: Date
    var speed: Double
}

class Storm: ObservableObject {
    private(set) var drops = Set<Raindrop>()
    private(set) var rainColor = Color(red: 0.25, green: 0.5, blue: 0.75)

    init(rainColor: Color? = nil) {
        if rainColor != nil {
            self.rainColor = rainColor!
        }
    }

    func setRainColor(rainColor: Color) {
        self.rainColor = rainColor
    }

    func update(to date: Date) {
        drops = drops.filter { $0.removalDate > date }
        drops.insert(Raindrop(xPosition: Double.random(in: 0 ... 1), removalDate: date + 1, speed: Double.random(in: 1 ... 2)))
    }
}

struct StormView: View {
    @StateObject private var storm = Storm()

    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                storm.update(to: timeline.date)

                for drop in storm.drops {
                    let age = timeline.date.distance(to: drop.removalDate)
                    let rect = CGRect(x: drop.xPosition * size.width, y: size.height - (size.height * age * drop.speed), width: 2, height: 10)
                    let shape = Capsule().path(in: rect)
                    context.fill(shape, with: .color(storm.rainColor))
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    StormView()
}
