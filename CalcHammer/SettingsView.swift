//
//  SettingsView.swift
//  CalcHammer
//
//  Created by Brett Hutt-Semple on 2024-01-21.
//

import SwiftUI

struct SettingsView: View {
    @Binding var showFavouritesTab: Bool
    @Binding var showHistoryTab: Bool
    
    var body: some View {
        VStack {
            Toggle("Show Favourites Tab:", isOn: $showFavouritesTab)
                .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
            Toggle("Show History Tab", isOn: $showHistoryTab)
                .padding(/*@START_MENU_TOKEN@*/.horizontal/*@END_MENU_TOKEN@*/)
        }
    }
}
