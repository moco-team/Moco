//
//  CardScan.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 14/11/23.
//

import CodeScanner
import SwiftUI

struct CardScan: View {
    @State private var scanResult: [String] = []

    var onComplete: (() -> Void)?

    var body: some View {
        ZStack {
            Color.bg.blue
            HStack {
                VStack(spacing: 30) {
                    Text("Posisikan kartu di dalam area kamera")
                        .customFont(.cherryBomb, size: 40)
                        .foregroundColor(.white)
                    VStack {
                        Text("Contoh :")
                            .customFont(.cherryBomb, size: 40)
                        LottieView(
                            fileName: "arrange_camera_to_barcode.json",
                            loopMode: .loop
                        )
                        .frame(height: Screen.height * 0.2)
                    }
                }
                VStack {
                    Text("Area Kamera :")
                        .customFont(.cherryBomb, size: 40)
                        .padding()
                    CodeScannerView(
                        codeTypes: [.qr],
                        scanMode: .oncePerCode,
                        completion: { result in
                            if case let .success(code) = result {
                                scanResult.append(code.string)
                                onComplete?()
                            }
                        }
                    ).cornerRadius(25)
                }
            }
        }.onAppear {
            scanResult = []
        }
    }
}

#Preview {
    CardScan()
}
