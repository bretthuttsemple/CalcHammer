//
//  DataManager.swift
//  CalcHammer
//
//  Created by Brett Hutt-Semple on 2024-02-11.
//

import Foundation
import SwiftData

//global static variables
struct GlobalData{
    static var unitSystems:Array = ["Select Unit Type","Length", "Mass", "Speed", "Temperature","Time"
                                    ,"Volume","Force","/Angles","/Number Systems"]
    
    static var lengthUnit:Array = ["Micrometers", "Millimeters","Centimeters","Meters","Kilometers","Inches","Feet","Yards","Mile","Nautical Miles"]
    static var lengthSymbol:Array = ["μm", "mm","cm","m","km", "in","ft","yd","mi","nmi"]
    
    static var massUnit:Array = ["Milligram","Grams","Kilogram","Metric Ton","Ounce","Pound","Long Ton","Short Ton"]
    static var massSymbol:Array = ["mg","g","kg","Mg","℥","lb","LT","tn"]

    static var speedUnit:Array = ["Meter per Second","Meter per Minute","Meter per Hour","Kilometer per Second","Kilometer per minute","Kilometer per Hour","Feet per Second","Miles per hour","knot"]
    static var speedSymbol:Array = ["m/s","m/min","m/hr","km/s","km/m","km/hr","ft/s","mi/hr","kn"]

    static var tempUnit:Array = ["Celsius (°C)","Fahrenheit (°F)","Kelvin (K)","Rankine (°Ra)"]
    static var tempSymbol:Array = ["°C","°F","K","°Ra"]

    static var timeUnit:Array = ["Millisecond","Second","Minute","Hour","Week","Year"]
    static var timeSymbol:Array = ["ms","s","min","hr","week","year"]

    static var volumeUnit:Array = ["Milliliter","Liter","Gallon","Pint","Quart","Cup"]
    static var volumeSymbol:Array = ["mL","L","gal","pt","qt","US cup"]
    
    static var forceUnit:Array = ["Newton","Kilonewton","Dyne","Pond","Kilopond","Ounce-force","Pound-Force","Poundal"]
    static var forceSymbol:Array = ["N","kN","dyn","p","kp","ozf","lbf","pdl"]
    
    static var angleUnit:Array = ["Degrees","Radians"]
    static var angleSymbol:Array = ["°","rad"]
    
    static var numberSystem:Array = ["Binary","Octal","Decimal","Hexadecimal"]
}

//History Manager Class
@Model
class HistoryItem: Identifiable {
    var id: String
    var historyText: String
    
    init(historyText: String) {
        self.id = UUID().uuidString
        self.historyText = historyText
        
    }
}
