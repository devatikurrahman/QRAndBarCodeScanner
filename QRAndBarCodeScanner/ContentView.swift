//
//  ContentView.swift
//  QRAndBarCodeScanner
//
//  Created by Atikur Rahman on 10/30/23.
//

import SwiftUI

struct ContentView: View {
    
    enum Tab {
        case Scan
        case Create
        case History
        case Setting
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
