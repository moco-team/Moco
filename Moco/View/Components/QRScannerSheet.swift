//
//  QRScannerSheet.swift
//  Moco
//
//  Created by Daniel Aprillio on 08/11/23.
//

import CodeScanner
import SwiftUI

struct QRScannerSheet: View {
    @State var scannerResult: [String] = []

    func getResult() -> [String] {
        return scannerResult
    }

    func clearResult() {
        scannerResult = []
    }

    var body: some View {
        VStack {
            CodeScannerView(
                codeTypes: [.qr],
                scanMode: .oncePerCode,
                completion: { result in
                    if case let .success(code) = result {
                        if let url = URL(string: code.string) {
                            UIApplication.shared.open(url)
                            self.scannerResult.append("\(url)")
                        }
                        //                    print(self.scannerResult)
                    }
                }
            )

//            ForEach(self.getResult(), id: \.self){result in
//                Text(result)
//            }
//
//            Button{
//                self.clearResult()
//            } label: {
//                Text("clear results")
//            }
        }
    }
}

#Preview {
    QRScannerSheet()
}
