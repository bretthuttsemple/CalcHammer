//
//  Header.swift
//  CalcHammer
//
//  Created by Brett Hutt-Semple on 2024-01-21.
//

import SwiftUI

// CalcHammerHeader.swift
import SwiftUI

struct CalcHammerHeader: View {
    var body: some View {
        VStack {
            HStack{
                Image("AppHeader")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40) // Adjust the size as needed
                    .padding(.horizontal)
                Text("CalcHammer")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            Divider()
        }
        .background(Color("BackgroundColor"))
    }
}

