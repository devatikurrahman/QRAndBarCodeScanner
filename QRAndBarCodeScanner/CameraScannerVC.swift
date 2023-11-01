//
//  CameraScannerVC.swift
//  QRAndBarCodeScanner
//
//  Created by Atikur Rahman on 10/31/23.
//

import UIKit
import AVFoundation

enum CameraError: String {
    case invalidDeviceInput = "Something is wrong with the camera. We are unable to capture the input."
    case invalidScannedValue = "The value scanned is not valid. This app scans EAN-8, EAN-13 and QR code."
}

protocol CameraScannerVCDelegate: AnyObject {
    func didFindScanValue(barcode: String)
    func didFindError(error: CameraError)
}

final class CameraScannerVC: UIViewController {
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    weak var scannerDelegate: CameraScannerVCDelegate?
    
    init(scannerDelegate: CameraScannerVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let previewLayer = previewLayer else {
            scannerDelegate?.didFindError(error: .invalidDeviceInput)
            return
        }
        
        previewLayer.frame = view.layer.bounds
    }
    
    private func setupCaptureSession() {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            scannerDelegate?.didFindError(error: .invalidDeviceInput)
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        do {
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            scannerDelegate?.didFindError(error: .invalidDeviceInput)
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            scannerDelegate?.didFindError(error: .invalidDeviceInput)
            return
        }
        
        let metaDataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metaDataOutput) {
            captureSession.addOutput(metaDataOutput)
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = [.codabar, .code39, .code39Mod43, .code93, .code128, .ean8, .ean13, .gs1DataBar, .gs1DataBarLimited, .gs1DataBarExpanded, .interleaved2of5, .itf14, .upce, .qr, .microQR, .microPDF417, .pdf417, .microPDF417, .dataMatrix]
        } else {
            scannerDelegate?.didFindError(error: .invalidDeviceInput)
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = .resizeAspectFill
        if let previewLayer = previewLayer {
            view.layer.addSublayer(previewLayer)
        } else {
            scannerDelegate?.didFindError(error: .invalidDeviceInput)
            return
        }
        
        captureSession.startRunning()
    }
}

extension CameraScannerVC: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first else {
            scannerDelegate?.didFindError(error: .invalidScannedValue)
            return
        }
        
        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else {
            scannerDelegate?.didFindError(error: .invalidScannedValue)
            return
        }
        
        guard let barcode = machineReadableObject.stringValue else {
            scannerDelegate?.didFindError(error: .invalidScannedValue)
            return
        }
        
        //guard let barcodeDescriptor = machineReadableObject.descriptor else {
        //    scannerDelegate?.didFindError(error: .invalidScannedValue)
        //    return
        //}
        
        scannerDelegate?.didFindScanValue(barcode: barcode)
        //captureSession.stopRunning()
    }
}

