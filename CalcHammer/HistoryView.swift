//
//  HistoryView.swift
//  CalcHammer
//
//  Created by Brett Hutt-Semple on 2024-01-21.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    
    @Environment(\.modelContext) private var context
    
    @Query private var conversionItems: [HistoryItem]
    
    var body: some View {
        VStack{
            if conversionItems.isEmpty {
                Text("No history items yet")
            }
            else {
                List {
                    ForEach(conversionItems.indices.reversed(), id: \.self) { index in
                        if index < conversionItems.count { // Ensure index is within bounds
                            let item = conversionItems[index]
                            Text("\(item.historyText)")
                        }
                    }
                    .onDelete { indexes in
                        for index in indexes {
                            let correctIndex = conversionItems.count - index - 1
                            deleteItem(conversionItems[correctIndex])
                        }
                    }
                }
            }
        }
        .background(Color("BackgroundColor"))
        .navigationTitle("History")
    }
    
    func deleteItem(_ item: HistoryItem){
        context.delete(item)
    }
}
