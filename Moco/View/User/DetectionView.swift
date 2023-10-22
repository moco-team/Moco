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
    @State private var correctCount = 0

    private static let maxDetectionCount = 100

    var doneHandler: (() -> Void)?

    var body: some View {
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
                correctCount += 1
                showPopup = true
            }
        }
        .popUp(isActive: $showPopup, title: "Selamat kamu berhasil menemukan Kursi!") {
            doneHandler?()
        }
        .task {
            objectDetectionViewModel.setTargetObject(.chair)
            objectDetectionViewModel.setDetectedObject(nil)
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
