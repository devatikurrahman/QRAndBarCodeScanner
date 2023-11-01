//
//  ScannerView.swift
//  QRAndBarCodeScanner
//
//  Created by Atikur Rahman on 11/2/23.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> CameraScannerVC {
        CameraScannerVC(scannerDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: CameraScannerVC, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    final class Coordinator: NSObject, CameraScannerVCDelegate {
        func didFindScanValue(barcode: String) {
            print("barcode: \(barcode)")
        }
        
        func didFindError(error: CameraError) {
            print("error: \(error.rawValue)")
        }
    }
}

#Preview {
    ScannerView()
}
