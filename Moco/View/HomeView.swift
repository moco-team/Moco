//
//  HomeView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 11/10/23.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @Environment(\.itemViewModel) private var itemViewModel
    @Environment(\.navigate) private var navigate

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.flexible())]) {
                    ForEach(itemViewModel.items.indices , id: \.self) { index in
                        VStack {
                            StoryBook(title: "\(itemViewModel.items[index]) - \(index)") {
                                navigate.append(.story("Bangers"))
                            }
                            Button("Delete") {
                                itemViewModel.deleteItem(at: index)
                            }
                        }
                    }
                }
                .padding(.horizontal, 30)
            }.scrollClipDisabled()
        }.navigationTitle("Your Collection")
        .toolbar {
            Button("Add") {
                itemViewModel.createItem()
            }
        }
    }
}

#Preview {
    @State var itemViewModel = ItemViewModel(repository: ItemRepository())

    return HomeView().environment(\.itemViewModel, itemViewModel)
}
