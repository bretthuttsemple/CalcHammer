//
//  ContentView.swift
//  CalcHammer
//
//  Created by Brett Hutt-Semple on 2024-01-17.
//

import SwiftUI

struct ContentView: View {
    //Vars used in SettingsView
    @State private var showFavouritesTab = false
    @State private var showHistoryTab = true
    
    var body: some View {
        VStack{
            CalcHammerHeader()
            
            TabView {
                if showFavouritesTab {
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
                if showHistoryTab {
                    HistoryView()
                        .tabItem {
                            Image(systemName: "clock")
                            Text("History")
                        }
                }
                
                SettingsView(showFavouritesTab: $showFavouritesTab, showHistoryTab: $showHistoryTab) //passes stateful vars to settings
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    ContentView()
}
