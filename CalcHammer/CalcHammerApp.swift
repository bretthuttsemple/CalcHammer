//
//  CalcHammerApp.swift
//  CalcHammer
//
//  Created by Brett Hutt-Semple on 2024-01-17.
//

import SwiftUI
import SwiftData

@main
struct CalcHammerApp: App {
    @StateObject var userSettings = UserSettings() // Initialize UserSettings
    
    var body: some Scene {
        WindowGroup {
            VStack{
                ContentView()
                    .accentColor(userSettings.accentColor) // Apply accent color globally
            }
        }
        .modelContainer(for: HistoryItem.self)
        .environmentObject(userSettings)
    }
}
