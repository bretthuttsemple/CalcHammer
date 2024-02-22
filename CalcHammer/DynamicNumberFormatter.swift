//
//  DynamicNumberFormatter.swift
//  CalcHammer
//
//  Created by Brett Hutt-Semple on 2024-02-21.
//

import Foundation
import SwiftUI

struct DynamicNumberFormat: ViewModifier {
    var number: Double

    func body(content: Content) -> some View {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 3
        let formattedNumber = formatter.string(from: NSNumber(value: number)) ?? ""
        return Text(formattedNumber)
    }
}
