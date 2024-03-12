//
//  ContentView.swift
//  CalcHammer
//
//  Created by Brett Hutt-Semple on 2024-01-17.
//

import SwiftUI

struct ContentView: View {
    //Vars used in SettingsView
    @StateObject var userSettings = UserSettings() // Initialize UserSettings
    
    var body: some View {
        VStack{
            CalcHammerHeader()
            
            TabView {
                if userSettings.showFavouritesTab {
                    FavouritesView()
                        .tabItem {
                            Image(systemName: "star")
                            Text("Favourites")
                        }
                }
                
                ConverterView()
                    .tabItem {
                        Image(systemName: "arrow.left.arrow.right")
                        Text("Converter")
                    }
                
                CalculatorView()
                    .tabItem {
                        Image(systemName: "minus.slash.plus")
                        Text("Calculators")
                    }
                if userSettings.showHistoryTab {
                    HistoryView()
                        .tabItem {
                            Image(systemName: "clock")
                            Text("History")
                        }
                }
                
                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
        }
        .background(Color("BackgroundColor"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environmentObject(UserSettings()) // Provide UserSettings to ContentView
    }
}

#Preview {
    ContentView()
}
