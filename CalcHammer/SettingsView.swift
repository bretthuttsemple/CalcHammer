//
//  SettingsView.swift
//  CalcHammer
//
//  Created by Brett Hutt-Semple on 2024-01-21.
//

import SwiftUI

class UserSettings: ObservableObject {
    @AppStorage("showFavouritesTab") var showFavouritesTab: Bool = false
    @AppStorage("showHistoryTab") var showHistoryTab: Bool = true
    @AppStorage("toggleFictionalUnits") var toggleFictionalUnits: Bool = false
    @AppStorage("toggleMultiConvert") var toggleMultiConvert:Bool = false
}

struct SettingsView: View {
    @StateObject var userSettings = UserSettings()

    var body: some View {
        VStack {
                    Toggle("Show Favourites Tab:", isOn: $userSettings.showFavouritesTab)
                        .padding(.horizontal)
                    Toggle("Show History Tab", isOn: $userSettings.showHistoryTab)
                        .padding(.horizontal)
                    Toggle("Include Non-Traditonal Units", isOn: $userSettings.toggleFictionalUnits)
                        .padding(.horizontal)
                    Toggle("Include Multi Convert Toggle", isOn: $userSettings.toggleMultiConvert)
                        .padding(.horizontal)
                }
        // Provide UserSettings to the environment
        .environmentObject(userSettings)
    }
}
