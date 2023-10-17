//
//  HomeView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 11/10/23.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @Environment(\.audioViewModel) private var audioViewModel

    @Environment(\.itemViewModel) private var itemViewModel
    @Environment(\.navigate) private var navigate

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.flexible())]) {
                    ForEach(itemViewModel.items) { item in
                        StoryBook(title: item.name) {
                            navigate.append(.story("Bangers"))
                        }
                    }
                }
                .padding(.horizontal, 30)
                .toolbar {
                    Button("Add") {
                        itemViewModel.createItem()
                    }
                    Button("Delete") {
                        itemViewModel.deleteItem(itemViewModel.items.count - 1)
                    }
                }
            }.scrollClipDisabled()
        }.navigationTitle("Your Collection")
            .onAppear {
                audioViewModel.playSound(soundFileName: "bg-story")
            }
    }
}

#Preview {
    @State var itemViewModel = ItemViewModel()

    return HomeView().environment(\.itemViewModel, itemViewModel)
}
