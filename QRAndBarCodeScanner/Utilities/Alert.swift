//
//  Alert.swift
//  QRAndBarCodeScanner
//
//  Created by Atikur Rahman on 11/3/23.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let invalidDeviceInput   = AlertItem(title: "Invalid Device Input",
                                            message: "Something is wrong with the camera. We are unable to capture the input.",
                                            dismissButton: .default(Text("OK")))
    
    static let invalidScannedValue  = AlertItem(title: "Invalid Scan Type",
                                            message: "The value scanned is not valid. This app scans EAN-8, EAN-13 and QR code.",
                                            dismissButton: .default(Text("OK")))
}
