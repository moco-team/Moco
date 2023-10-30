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

    @State private var detectionPromptViewModel = DetectionPromptViewModel()

    private let maxDetectionCount = 100

    var doneHandler: (() -> Void)?

    var body: some View {
        ZStack {
            if !objectDetectionViewModel.isMatch {
                HostedViewController { detectedObject in
                    print(detectedObject ?? "")
                    objectDetectionViewModel.setDetectedObject(DetectionValue(rawValue: detectedObject ?? ""))
                }.environmentObject(objectDetectionViewModel)
                    .ignoresSafeArea()
                Image("Story/Content/Story1/Pages/Page7/background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .background(.clear)
                if detectionPromptViewModel.correctCount > 0 {
                    CircularProgressView(progress: Double(detectionPromptViewModel.correctCount) / 100.0) {
                        progress in
                        Text("\(progress * 100, specifier: "%.0f")%")
                            .customFont(.didactGothic, size: 50)
                            .bold()
                    }
                }
            }
        }
        .onChange(of: objectDetectionViewModel.isMatch) {
            if objectDetectionViewModel.isMatch {
                if detectionPromptViewModel.correctCount < maxDetectionCount {
                    detectionPromptViewModel.incCorrectCount()
                }
                objectDetectionViewModel.setDetectedObject(nil)
                if detectionPromptViewModel.correctCount >= maxDetectionCount {
                    detectionPromptViewModel.showPopup = true
                    objectDetectionViewModel.shouldStopSession = true
                }
            }
        }
        .popUp(isActive: $detectionPromptViewModel.showPopup, title: "Selamat kamu berhasil menemukan Kursi!") {
            doneHandler?()
        }
        .task {
            objectDetectionViewModel.shouldStopSession = false
            objectDetectionViewModel.setTargetObject([.chair, .couch])
            objectDetectionViewModel.setDetectedObject(nil)
        }
    }
}

#Preview {
    DetectionView()
}
