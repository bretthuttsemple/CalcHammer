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
                AdaptiveImage(light: Image("AppHeaderL"), dark: Image("AppHeaderD"))
                    .frame(width: 40, height: 40) // Adjust the size as needed
                    .padding(.horizontal)
                Text("CalcHammer")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            Divider()
        }
    }
}

struct AdaptiveImage: View {
    @Environment(\.colorScheme) var colorScheme
    let light: Image
    let dark: Image

    var body: some View {
        let image = colorScheme == .light ? light : dark
        return image.resizable()
    }
}

