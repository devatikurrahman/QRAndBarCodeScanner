//
//  CameraScannerVC.swift
//  QRAndBarCodeScanner
//
//  Created by Atikur Rahman on 10/31/23.
//

import UIKit
import AVFoundation

protocol CameraScannerVCDelegate: AnyObject {
    func didFindScanValue(barcode: String)
}

final class CameraScannerVC: UIViewController {
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer
    weak var scannerDelegate: CameraScannerVCDelegate?
    
    init(scannerDelegate: CameraScannerVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

