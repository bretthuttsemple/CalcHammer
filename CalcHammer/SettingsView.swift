//
//  SettingsView.swift
//  CalcHammer
//
//  Created by Brett Hutt-Semple on 2024-01-21.
//

import SwiftUI

class UserSettings: ObservableObject {
    @AppStorage("showFavouritesTab") var showFavouritesTab: Bool = true
    @AppStorage("showHistoryTab") var showHistoryTab: Bool = true
    @AppStorage("toggleFictionalUnits") var toggleFictionalUnits: Bool = false
    @AppStorage("toggleMultiConvert") var toggleMultiConvert: Bool = true
    @AppStorage("accentColorData") var accentColorData: Data = Color.blue.toData()
    
    var accentColor: Color {
        Color.fromData(accentColorData) ?? .blue
    }
    
    var accentColorBinding: Binding<Color> {
        Binding {
            self.accentColor
        } set: { newValue in
            self.accentColorData = newValue.toData()
        }
    }
}

extension Color {
    func toData() -> Data {
        let colorComponents = self.components()
        let colorData = try! JSONEncoder().encode(colorComponents)
        return colorData
    }
    
    static func fromData(_ data: Data) -> Color? {
        guard let colorComponents = try? JSONDecoder().decode([CGFloat].self, from: data) else {
            return nil
        }
        return Color(red: Double(colorComponents[0]), green: Double(colorComponents[1]), blue: Double(colorComponents[2]), opacity: Double(colorComponents[3]))
    }
    
    private func components() -> [CGFloat] {
        guard let components = UIColor(self).cgColor.components else {
            return []
        }
        return components
    }
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
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Color")
                        .font(.headline)
                    HStack {
                        Text("Choose a custom color to personalize CalcHammer to your liking")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Spacer()
                        ColorPicker("Select Color", selection: userSettings.accentColorBinding)
                            .labelsHidden()
                            .padding(.horizontal)
                    }
                }
                .padding(.vertical,4)
                
                VStack(alignment: .leading) {
                    Text("Favourites")
                        .font(.headline)
                    HStack {
                        Text("The Favourites tab is where you store your preferred calculators. Turning this setting on/off enables/disables the Favourites feature. Your favourites remain saved even when this setting is turned off.")
                            .font(.footnote)
                            .foregroundColor(.secondary)
//                        Spacer()
                        Toggle("", isOn: $userSettings.showFavouritesTab)
                            .frame(width: 80) // Adjust the width as needed
                    }
                }
                .padding(.vertical,2)
                
                VStack(alignment: .leading) {
                    Text("History")
                        .font(.headline)
                    HStack {
                        Text("The History tab records your recent calculations or conversions. Enabling/disabling this setting turns the History tab on/off. When turned off, new items won't be saved, but existing ones remain.")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Spacer()
                        Toggle("", isOn: $userSettings.showHistoryTab)
                            .frame(width: 80) // Adjust the width as needed
                    }
                }
                .padding(.vertical,2)
                
                VStack(alignment: .leading) {
                    Text("Extra Units")
                        .font(.headline)
                    HStack {
                        Text("Enabling the Extra Units setting provides access to additional, non-traditional units. Disabling it hides these units.")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Spacer()
                        Toggle("", isOn: $userSettings.toggleMultiConvert)
                            .frame(width: 80) // Adjust the width as needed
                    }
                }
                .padding(.vertical,2)
                
                VStack(alignment: .leading) {
                    Text("Multi-Convert")
                        .font(.headline)
                    HStack {
                        Text("Enabling Multi-Convert allows the use of an additional toggle feature in the conversion tab. This toggle permits combining two measurements of different units to yield a sum in a different unit.")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Spacer()
                        Toggle("", isOn: $userSettings.toggleFictionalUnits)
                            .frame(width: 80) // Adjust the width as needed
                    }
                }
                .padding(.vertical,2)

                Spacer()
            }
            .padding()
            .environmentObject(userSettings)
        }
    }
