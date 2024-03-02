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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: HistoryItem.self)

    }
}
