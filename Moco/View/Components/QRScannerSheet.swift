//
//  QRScannerSheet.swift
//  Moco
//
//  Created by Daniel Aprillio on 08/11/23.
//

import SwiftUI
import CodeScanner

struct QRScannerSheet: View {
    
    @State var isPresentingScanner: Bool = false
    @State var scannerResult: String = "Scan QR Code to get started!"
    
    var body: some View {
        CodeScannerView(
            codeTypes: [.qr],
            completion: { result in
                if case let .success(code) = result {
                    if let url = URL(string: code.string) {
                        UIApplication.shared.open(url)
                        self.scannerResult = "\(url)"
                    }
                    self.isPresentingScanner = false
                }
            }
        )
    }
}

#Preview {
    QRScannerSheet()
}
