//
//  CardScan.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 14/11/23.
//

import CodeScanner
import SwiftUI

struct CardScan: View {
    @Environment(\.audioViewModel) private var audioViewModel

    @Binding var scanResult: [String]

    var onComplete: (() -> Void)?

    var body: some View {
        ZStack {
            Color.bg.blue
            HStack {
                VStack(spacing: 30) {
                    Text("Posisikan kartu di dalam area kamera")
                        .customFont(.cherryBomb, size: 40)
                        .foregroundColor(.blue2Txt)
                        .glowBorder(color: .white, lineWidth: 6)
                    VStack {
                        LottieView(
                            fileName: "arrange_camera_to_barcode.json",
                            loopMode: .loop
                        )
                        .frame(height: Screen.height * 0.2)
                    }
                }
                VStack {
                    CodeScannerView(
                        codeTypes: [.qr],
                        scanMode: .oncePerCode,
                        completion: { result in
                            if case let .success(code) = result {
                                scanResult.append(code.string)
                                onComplete?()
                            }
                        }
                    )
                }
            }
        }.task {
            scanResult = []
            audioViewModel.playSound(
                soundFileName: "arahkan_kamera",
                type: .m4a,
                category: .narration
            )
        }
    }
}

#Preview {
    CardScan(scanResult: .constant([]))
}
