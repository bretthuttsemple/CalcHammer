//
//  ButtonStyle.swift
//  CalcHammer
//
//  Created by Brett Hutt-Semple on 2024-03-20.
//

import Foundation
import SwiftUI

struct MyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 20) // Adjust horizontal padding as needed
            .padding(.vertical, 8) // Adjust vertical padding as needed
            .background(
                ZStack {
                    // Fill color
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color("BoxFillColors"))
                    
                    // Stroke color
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("BoxStrokeColors"))
                }
            )
            .contentShape(Rectangle()) // Make entire area tappable
            .foregroundColor(Color.accentColor) // Text color
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // Apply scale effect when pressed
    }
}

struct MyTextStyle: ViewModifier {
    enum Style {
        case title
    }
    
    let style: Style
    
    func body(content: Content) -> some View {
        switch style {
        case .title:
            return content
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal, 20) // Adjust horizontal padding as needed
                .padding(.top, 20) // Adjust vertical padding as needed
                .foregroundColor(Color.primary) // Text color
                .multilineTextAlignment(.leading) // Left justify text
        }
    }
}

extension Text {
    func myTextStyle(_ style: MyTextStyle.Style) -> some View {
        return self.modifier(MyTextStyle(style: style))
    }
}
