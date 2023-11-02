//
//  ContentView.swift
//  QRAndBarCodeScanner
//
//  Created by Atikur Rahman on 10/30/23.
//

import SwiftUI

struct ScanView: View {
    
    @StateObject var viewModel = ScannerViewModel()

    var body: some View {
        ZStack {
            //LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .topLeading, endPoint: .bottomTrailing)
                //.edgesIgnoringSafeArea(.all)
            ZStack {
                // This piece of code is working
                //ScannerView()
                //.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 300)
            
                ScannerView(scannedCode: $viewModel.scannedCode, alertItem: $viewModel.alertItem)
                    .frame(width: 250, height: 250)
                    .foregroundColor(.white.opacity(0.5))
                    //.blendMode(.destinationOut)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(.white, lineWidth: 3))
                 
            }
            .compositingGroup()
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: Text(alertItem.title),
                message: Text(alertItem.message),
                dismissButton: alertItem.dismissButton)
        }
    }
}

#Preview {
    ScanView()
}
