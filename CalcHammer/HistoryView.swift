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
        List{
            ForEach (conversionItems) { item in
                Text("\(item.historyText)")
            }
            .onDelete{ indexes in
                for index in indexes {
                    deleteItem(conversionItems[index])
                }
                
            }
        }
    }
    func deleteItem(_ item: HistoryItem){
        context.delete(item)
    }
}
