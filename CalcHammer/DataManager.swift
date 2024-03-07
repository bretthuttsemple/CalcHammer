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
    static var unitSystems:Array = ["Select Unit Type","Length", "Mass", "Speed", "Temperature","Time","Volume","Force","/Angles","/Number Systems"]
    
    static var lengthUnit:Array = ["Micrometers", "Millimeters","Centimeters","Meters","Kilometers","Inches","Feet","Yards","Mile","Nautical Miles","Football Fields","Marathons","Furlong","Light Years","Beard Seconds","Hammer Units"]
    static var lengthSymbol:Array = ["μm", "mm","cm","m","km", "in","ft","yd","mi","nmi","Football Fields","Marathons","Furlongs","Light Years","Beard Seconds","hu"]
    
    static var massUnit:Array = ["Milligram","Grams","Kilograms","Metric Tons","Ounces","Pounds","Long Tons","Short Tons","Firkins","Bricks","Loonies"]
    static var massSymbol:Array = ["mg","g","kg","Mg","℥","lb","LT","tn","Firkins","Bricks","Loonies"]

    static var speedUnit:Array = ["Meters per Second","Meters per Minute","Meters per Hour","Kilometers per Second","Kilometers per minute","Kilometers per Hour","Feet per Second","Miles per hour","knots","Light Years","Beard Seconds","Hammer Units per Second"]
    static var speedSymbol:Array = ["m/s","m/min","m/hr","km/s","km/m","km/hr","ft/s","mi/hr","kn","light years","beard seconds","hu/s"]

    static var tempUnit:Array = ["Celsius (°C)","Fahrenheit (°F)","Kelvin (K)","Rankine (°Ra)"]
    static var tempSymbol:Array = ["°C","°F","K","°Ra"]

    static var timeUnit:Array = ["Millisecond","Second","Minute","Hour","Week","Year","Jiffy","Nanocentury","Fortnight"]
    static var timeSymbol:Array = ["ms","s","min","hr","week","year","jiffy","nanocentury","fortnight"]

    static var volumeUnit:Array = ["Milliliter","Liter","Gallon","Pint","Quart","Cup","Standard Shots","Standard Cans"]
    static var volumeSymbol:Array = ["mL","L","gal","pt","qt","US cup","shots","cans"]
    
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
