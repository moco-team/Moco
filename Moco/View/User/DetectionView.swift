//
//  DetectionView.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 13/10/23.
//

import SwiftData
import SwiftUI

struct DetectionView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var objectDetectionViewModel: ObjectDetectionViewModel
    @Query private var items: [Item]
    @State private var showPopup = false

    var doneHandler: (() -> Void)?

    var body: some View {
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }

        ZStack {
            if !objectDetectionViewModel.isMatch {
                HostedViewController { detectedObject in
                    print(detectedObject)
                    if DetectionValue(rawValue: detectedObject) == objectDetectionViewModel.getTargetObject() {
                        objectDetectionViewModel.setDetectedObject(DetectionValue(rawValue: detectedObject))
                    }
                }.environmentObject(objectDetectionViewModel)
                    .ignoresSafeArea()
                Image("Story/Content/Story1/Pages/Page7/background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .background(.clear)
            }
        }
        .onChange(of: objectDetectionViewModel.isMatch) {
            if objectDetectionViewModel.isMatch {
                showPopup = true
            }
        }
        .popUp(isActive: $showPopup, title: "Selamat kamu berhasil menemukan Orang!") {
            doneHandler?()
        }
        .task {
            objectDetectionViewModel.setTargetObject(.person)
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item()
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    DetectionView()
        .modelContainer(for: Item.self, inMemory: true)
}
