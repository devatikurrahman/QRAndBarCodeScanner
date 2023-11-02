//
//  ContentView.swift
//  QRAndBarCodeScanner
//
//  Created by Atikur Rahman on 10/30/23.
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

struct ScanView: View {
    
    @State private var scannedCode = ""
    @State private var alertItem: AlertItem?
    
    var body: some View {
        ZStack {
            //LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .topLeading, endPoint: .bottomTrailing)
                //.edgesIgnoringSafeArea(.all)
            ZStack {
                // This piece of code is working
                //ScannerView()
                //.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 300)
            
                ScannerView(scannedCode: $scannedCode, alertItem: $alertItem)
                    .frame(width: 250, height: 250)
                    .foregroundColor(.white.opacity(0.5))
                    //.blendMode(.destinationOut)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(.white, lineWidth: 3))
                 
            }
            .compositingGroup()
        }
        .alert(item: $alertItem) { alertItem in
            Alert(title: Text(alertItem.title),
                message: Text(alertItem.message),
                dismissButton: alertItem.dismissButton)
        }
    }
}

#Preview {
    ScanView()
}
