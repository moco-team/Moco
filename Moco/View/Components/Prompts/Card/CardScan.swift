//
//  CardScan.swift
//  Moco
//
//  Created by Aaron Christopher Tanhar on 14/11/23.
//

import AVFoundation
import CodeScanner
import SwiftUI

enum CameraMode {
    case front
    case back

    mutating func toggle() {
        switch self {
        case .back:
            self = .front
        case .front:
            self = .back
        }
    }
}

struct CardScan: View {
    @Environment(\.audioViewModel) private var audioViewModel

    @State private var cameraMode = CameraMode.back
    @Binding var scanResult: [String]

    var onComplete: (() -> Void)?

    var captureDevice: AVCaptureDevice? {
        do {
            let captureDevice = AVCaptureDevice.default(cameraMode == .back ?
                .builtInTripleCamera :
                .builtInWideAngleCamera,
                for: .video,
                position: (cameraMode == .back) ? .back : .front)
            try captureDevice?.lockForConfiguration()
            if let autoFocusRangeSupported = captureDevice?.isAutoFocusRangeRestrictionSupported, autoFocusRangeSupported {
                captureDevice?.autoFocusRangeRestriction = .near
            }
            if let isFocusModeSupported = captureDevice?.isFocusModeSupported(.continuousAutoFocus), isFocusModeSupported {
                captureDevice?.focusMode = .continuousAutoFocus
            }

            return captureDevice
        } catch {
            return nil
        }
    }

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
                    ZStack {
                        CodeScannerView(
                            codeTypes: [.qr],
                            scanMode: .oncePerCode,
                            videoCaptureDevice: captureDevice,
                            completion: { result in
                                if case let .success(code) = result {
                                    scanResult.append(code.string)
                                    onComplete?()
                                }
                            }
                        ).id(cameraMode)
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                SfxButton {
                                    cameraMode.toggle()
                                } label: {
                                    Image("Buttons/button-switch-camera").resizable().scaledToFit()
                                }.buttonStyle(
                                    CircleButton(
                                        width: 80,
                                        height: 80,
                                        backgroundColor: .clear,
                                        foregroundColor: .clear
                                    )
                                ).padding()
                            }
                        }
                    }
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
