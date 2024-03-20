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
    
    @State private var isFavouritesExpanded = false
    @State private var isHistoryExpanded = false
    @State private var isFictionalUnitsExpanded = false
    @State private var isMultiConvertExpanded = false

    var body: some View {
            VStack {
                Text("Settings")
                    .myTextStyle(.title)
                    .frame(maxWidth: .infinity, alignment: .leading) // Ensure left alignment
                
                CollapsibleSettingRow(label: "Show Favourites Tab", description: "Toggle to show or hide the Favourites tab", setting: $userSettings.showFavouritesTab, isExpanded: $isFavouritesExpanded)
                CollapsibleSettingRow(label: "Show History Tab", description: "Toggle to show or hide the History tab", setting: $userSettings.showHistoryTab, isExpanded: $isHistoryExpanded)
                CollapsibleSettingRow(label: "Include Non-Traditonal Units", description: "Toggle to include non-traditional units", setting: $userSettings.toggleFictionalUnits, isExpanded: $isFictionalUnitsExpanded)
                CollapsibleSettingRow(label: "Include Multi Convert Toggle", description: "Toggle to include the Multi Convert toggle", setting: $userSettings.toggleMultiConvert, isExpanded: $isMultiConvertExpanded)
            }
            .padding(.horizontal)
            .environmentObject(userSettings)
        }
    }

struct CollapsibleSettingRow: View {
    let label: String
    let description: String
    @Binding var setting: Bool
    @Binding var isExpanded: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(label)
                    .font(.headline)
                Spacer()
                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(.accentColor)
            }
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }
            if isExpanded {
                HStack {
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Spacer()
                    Toggle("", isOn: $setting)
                        .padding(.trailing, 20)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .contentShape(Rectangle())
            }
        }
//        .background(Color("BackgroundColor"))
        .navigationTitle("Settings")
    }
}

