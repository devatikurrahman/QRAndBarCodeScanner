//
//  ContentView.swift
//  QRAndBarCodeScanner
//
//  Created by Atikur Rahman on 10/30/23.
//

import SwiftUI

struct ScanView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            ZStack {
                Rectangle()
                    .foregroundColor(.black.opacity(0.5))
                Rectangle()
                    .frame(width: 250, height: 250)
                    .blendMode(.destinationOut)
                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(.white, lineWidth: 3))
            }
            .compositingGroup()
        }
    }
}

#Preview {
    ScanView()
}
