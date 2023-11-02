//
//  ScannerView.swift
//  QRAndBarCodeScanner
//
//  Created by Atikur Rahman on 11/2/23.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    
    @Binding var scannedCode: String
    @Binding var alertItem: AlertItem?
    
    func makeUIViewController(context: Context) -> CameraScannerVC {
        CameraScannerVC(scannerDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: CameraScannerVC, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView: self)
    }
    
    final class Coordinator: NSObject, CameraScannerVCDelegate {
        private let scannerView: ScannerView
        
        init(scannerView: ScannerView) {
            self.scannerView = scannerView
        }
        
        func didFindScanValue(barcode: String) {
            scannerView.scannedCode = barcode
            print("barcode: \(barcode)")
        }
        
        func didFindError(error: CameraError) {
            switch error {
            case .invalidDeviceInput:
                scannerView.alertItem = AlertContext.invalidDeviceInput
            case .invalidScannedValue:
                scannerView.alertItem = AlertContext.invalidScannedValue
            }
        }
    }
}

#Preview {
    ScannerView(scannedCode: .constant("1234567890"), alertItem: .constant(AlertContext.invalidDeviceInput))
}
