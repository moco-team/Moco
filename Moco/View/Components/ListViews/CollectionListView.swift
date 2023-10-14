//
//  CollectionListView.swift
//  Moco
//
//  Created by Nur Azizah on 12/10/23.
//

import SwiftData
import SwiftUI

struct CollectionListView: View {
    @Query var collectionList: [CollectionModel]

    var collectionVM: CollectionViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(collectionList) { collection in
                    CollectionRowView(collection: collection, collectionVM: collectionVM)
                }
            }
        }
    }
}

#Preview {
    CollectionListView(collectionVM: CollectionViewModel())
}
