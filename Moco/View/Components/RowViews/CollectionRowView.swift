//
//  CollectionRowView.swift
//  Moco
//
//  Created by Nur Azizah on 12/10/23.
//

import SwiftUI
import SwiftData

struct CollectionRowView: View {
    @Environment(\.modelContext) private var context
    
    var collection: CollectionModel
    var collectionVM: CollectionViewModel
    
    var body: some View {
        VStack(spacing: 25) {
            Image(systemName: "square.and.arrow.up.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text(collection.collectionDescription)
                .fontWeight(.bold)
            
            Button(action: {
                collectionVM.deleteCollection(context: context, collection: collection)
            }, label: {
                Text("Delete")
            })
        }
        .padding(.leading, 10)
    }
}

#Preview {
    CollectionRowView(collection: CollectionModel(collectionDescription: "Description Template", image: "Image Template"), collectionVM: CollectionViewModel())
}
