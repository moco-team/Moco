//
//  CollectionView.swift
//  Moco
//
//  Created by Nur Azizah on 12/10/23.
//

import SwiftData
import SwiftUI

struct CollectionView: View {
    @Environment(\.modelContext) private var context

    var collectionVM: CollectionViewModel = .init()

    var body: some View {
        VStack {
            VStack {
                Header()
                Spacer()
            }

            VStack {
                HStack {
                    Text("Pilih Koleksi")
                        .fontWeight(.bold)
                        .font(.title)
                    Spacer()
                }

                CollectionListView(collectionVM: collectionVM)
                    .padding(.top, 30)
            }

            Button(action: {
                collectionVM.addCollection(context: context, collection: CollectionModel(collectionDescription: "Deskripsi koleksi", image: "Image"))
            }, label: {
                Text("press")
            })
        }
        .padding(.bottom, 250)
        .padding([.trailing, .leading, .top], 40)
    }
}

#Preview {
    CollectionView()
        .modelContainer(for: CollectionModel.self, inMemory: true)
}
