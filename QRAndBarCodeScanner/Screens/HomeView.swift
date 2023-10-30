//
//  HomeView.swift
//  QRAndBarCodeScanner
//
//  Created by Atikur Rahman on 10/30/23.
//

import SwiftUI

struct HomeView: View {
    enum Tab {
        case Scan
        case Create
        case History
        case Setting
    }
    
    @State private var selectedTab: Tab = .Scan
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ScanView()
                .tabItem {
                    Label("Scan", systemImage: "star")
                }
                .tag(Tab.Scan)
            CreateView()
                .tabItem {
                    Label("Create", systemImage: "star")
                }
                .tag(Tab.Create)
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "star")
                }
                .tag(Tab.History)
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "star")
                }
                .tag(Tab.Setting)
        }
    }
}

#Preview {
    HomeView()
}
