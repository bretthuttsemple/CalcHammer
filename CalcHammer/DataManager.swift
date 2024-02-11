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
                                    ,"Volume","Force","/Density","/Angles","/Number Systems"]
    
    static var lengthUnit:Array = ["Micrometers (μm)", "Millimeters (mm)","Centimeters (cm)","Meters (m)","Kilometers (km)",
                                   "Inches (in)","Feet (ft)","Yards (yd)","Mile (mi)","Nautical Miles (nmi)"]
    
    static var massUnit:Array = ["Milligram (mg)","Grams (g)","Kilogram (kg)","Metric Ton (Mg)","Ounce (℥)","Pound (lb)","Long Ton (LT)","Short Ton (tn)"]
    
    //maybe rethink how speed is done (2 arrays for each side of the 'per')
    static var speedUnit:Array = ["Meter per Second (m/s)","Meter per Minute (m/min)","Meter per Hour (m/hr)","Kilometer per Second (km/s)","Kilometer per minute (km/m)","Kilometer per Hour (km/hr)","Feet per Second (ft/s)","Miles per hour (mi/hr)","knot (kn)"]
    
    static var tempUnit:Array = ["Celsius (°C)","Fahrenheit (°F)","Kelvin (K)","Rankine (°Ra)"]
    
    static var timeUnit:Array = ["Millisecond (ms)","Second (s)","Minute (min)","Hour (hr)","Week","Year"]
    
    //research more units of volume
    static var volumeUnit:Array = ["Milliliter (mL)","Liter (L)","Gallon (gal)","Pint (pt)","Quart (qt)","Cup (US)"]
    
    static var forceUnit:Array = ["Newton (N)","Kilonewton (kN)","Dyne (dyn)","Pond (p)","Kilopond (kp)","Ounce-force (ozf)","Pound-Force (lbf)","Poundal (pdl)"]
    
    //same as speed, rethink how we do it (2 dimensional array?)
    static var densityUnit:Array = ["Gram per Litre"]
    
    static var angleUnit:Array = ["Degrees (°)","Radians (rad)"]
    
    static var numberSystem:Array = ["Binary","Octal","Decimal","Hexadecimal"]
}

//History Manager Class
@Model
class ConversionHistoryItem: Identifiable {
    var id: String
    var inputUnit: String
    var outputUnit: String
    var inputNum: Double
    var outputNum: Double
    
    init(inputUnit: String, outputUnit: String, inputNum: Double, outputNum: Double) {
        self.id = UUID().uuidString
        self.inputUnit = inputUnit
        self.outputUnit = outputUnit
        self.inputNum = inputNum
        self.outputNum = outputNum
    }
}
