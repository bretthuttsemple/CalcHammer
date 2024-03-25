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
    
    @State private var showingDeleteAlert = false
    
    var body: some View {
        VStack{
            Text("History")
                .myTextStyle(.title)
                .frame(maxWidth: .infinity, alignment: .leading) // Ensure left alignment
            
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
                .alert(isPresented: $showingDeleteAlert) {
                    Alert(
                        title: Text("Delete All History Items"),
                        message: Text("Are you sure you want to delete all history items?"),
                        primaryButton: .cancel(),
                        secondaryButton: .destructive(Text("Delete All")) {
                            deleteAllItems()
                        }
                    )
                }
                
                Button(action: {
                    showingDeleteAlert = true
                }) {
                    HStack {
                        Image(systemName: "trash")
                        Text("Delete All")
                    }
                    .foregroundColor(.red)
                }
                .padding()
                .disabled(conversionItems.isEmpty)
            }
            Spacer()
        }
    }
    
    func deleteItem(_ item: HistoryItem){
        context.delete(item)
    }
    func deleteAllItems() {
            for item in conversionItems {
                deleteItem(item)
            }
        }
}
