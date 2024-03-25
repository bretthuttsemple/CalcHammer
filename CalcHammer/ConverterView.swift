//
//  ConverterView.swift
//  CalcHammer
//
//  Created by Brett Hutt-Semple on 2024-01-21.
//

import SwiftUI
import UIKit

extension NumberFormatter {//number formatter used to assign the minimal number of decimal digits for output
    var decimalNumberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
}


struct ConverterView: View {
    // Add a state variable to store the selected unit
    @State private var selectedUnitIndex = 0 //unit type
    @State private var selectedUnitIndex2 = 0 //input unit 1
    @State private var selectedUnitIndex3 = 0 //output unit
    @State private var selectedUnitIndex4 = 0 //input unit 2
    
    @State private var inputValue:Double = 0
    @State private var inputValue2:Double = 0
    @State var output:Double = 0
    
    @State private var multiConvert:Bool = false //variable used the multi convert toggle
    
    @Environment(\.modelContext) private var context //links to historyItems
    
    @StateObject var userSettings = UserSettings() // Initialize UserSettings

    func buttonPressConvert(unitType: Int,inputUnit:Int,outputUnit:Int,inputNum:Double) -> Double{
        //Function for deciding which conversion function to call
        //after converting the input, the output is added to historyItems
        var convertedOutput:Double = 0
        
        if unitType == 1 //length
        {
            convertedOutput = lengthConverter(inputUnit: inputUnit, outputUnit: outputUnit, inputNum: inputNum)
            addHistoryItem(inputUnitW: GlobalData.lengthSymbol[inputUnit], outputUnitW: GlobalData.lengthSymbol[outputUnit], inputNum: inputNum, outputNum: convertedOutput)
        }
        else if unitType == 2 //mass
        {
            convertedOutput = massConverter(inputUnit: inputUnit, outputUnit: outputUnit, inputNum: inputNum)
            addHistoryItem(inputUnitW: GlobalData.massSymbol[inputUnit], outputUnitW: GlobalData.massSymbol[outputUnit], inputNum: inputNum, outputNum: convertedOutput)

        }
        else if unitType == 3 //speed
        {
            convertedOutput = speedConverter(inputUnit: inputUnit, outputUnit: outputUnit, inputNum: inputNum)
            addHistoryItem(inputUnitW: GlobalData.speedSymbol[inputUnit], outputUnitW: GlobalData.speedSymbol[outputUnit], inputNum: inputNum, outputNum: convertedOutput)

        }
        else if unitType == 4 //temp
        {
            convertedOutput = tempConverter(inputUnit: inputUnit, outputUnit: outputUnit, inputNum: inputNum)
            addHistoryItem(inputUnitW: GlobalData.tempSymbol[inputUnit], outputUnitW: GlobalData.tempSymbol[outputUnit], inputNum: inputNum, outputNum: convertedOutput)

        }
        else if unitType == 5 //time
        {
            convertedOutput = timeConverter(inputUnit: inputUnit, outputUnit: outputUnit, inputNum: inputNum)
            addHistoryItem(inputUnitW: GlobalData.timeSymbol[inputUnit], outputUnitW: GlobalData.timeSymbol[outputUnit], inputNum: inputNum, outputNum: convertedOutput)

        }
        else if unitType == 6 //volume
        {
            convertedOutput = volumeConverter(inputUnit: inputUnit, outputUnit: outputUnit, inputNum: inputNum)
            addHistoryItem(inputUnitW: GlobalData.volumeSymbol[inputUnit], outputUnitW: GlobalData.volumeSymbol[outputUnit], inputNum: inputNum, outputNum: convertedOutput)

        }
        else if unitType == 7 //force
        {
            convertedOutput = forceConverter(inputUnit: inputUnit, outputUnit: outputUnit, inputNum: inputNum)
            addHistoryItem(inputUnitW: GlobalData.forceSymbol[inputUnit], outputUnitW: GlobalData.forceSymbol[outputUnit], inputNum: inputNum, outputNum: convertedOutput)

        }
        else if unitType == 8 //angles
        {
            convertedOutput = angleConverter(inputUnit: inputUnit, outputUnit: outputUnit, inputNum: inputNum)
            addHistoryItem(inputUnitW: GlobalData.angleSymbol[inputUnit], outputUnitW: GlobalData.angleSymbol[outputUnit], inputNum: inputNum, outputNum: convertedOutput)
        }
        else if unitType == 9 //num systems
        {
            //tbd
        }
        else //no unit selected
        {
            print("ERROR: conversion with out inputs")
        }
        return convertedOutput
        
    }
    
    func resetSelectedIndices() {
        selectedUnitIndex2 = 0
        selectedUnitIndex3 = 0
        selectedUnitIndex4 = 0
    }
    
    func buttonPressMultiConvert(unitType: Int,inputUnit:Int,inputUnit2:Int,outputUnit:Int,inputNum:Double,inputNum2:Double) -> Double{
        //Function for which adds two different measurements of the same type together
        //after converting the sum of the inputs, the output is added to historyItems
        var convertedOutput:Double = 0
        
        if unitType == 1 //length
        {
            convertedOutput = lengthConverter(inputUnit: inputUnit, outputUnit: outputUnit, inputNum: inputNum) + lengthConverter(inputUnit: inputUnit2, outputUnit: outputUnit, inputNum: inputNum2)
            addMultiHistoryItem(inputUnitW: GlobalData.lengthSymbol[inputUnit], inputUnitW2: GlobalData.lengthSymbol[inputUnit2], outputUnitW: GlobalData.lengthSymbol[outputUnit], inputNum: inputNum, inputNum2: inputNum2, outputNum: convertedOutput)
        }
        else if unitType == 2 //mass
        {
            convertedOutput = massConverter(inputUnit: inputUnit, outputUnit: outputUnit, inputNum: inputNum) + massConverter(inputUnit: inputUnit2, outputUnit: outputUnit, inputNum: inputNum2)
            addMultiHistoryItem(inputUnitW: GlobalData.massSymbol[inputUnit], inputUnitW2: GlobalData.massSymbol[inputUnit2], outputUnitW: GlobalData.massSymbol[outputUnit], inputNum: inputNum, inputNum2: inputNum2, outputNum: convertedOutput)

        }
        else if unitType == 3 //speed
        {
            convertedOutput = speedConverter(inputUnit: inputUnit, outputUnit: outputUnit, inputNum: inputNum) + speedConverter(inputUnit: inputUnit2, outputUnit: outputUnit, inputNum: inputNum2)
            addMultiHistoryItem(inputUnitW: GlobalData.speedSymbol[inputUnit], inputUnitW2: GlobalData.speedSymbol[inputUnit2], outputUnitW: GlobalData.speedSymbol[outputUnit], inputNum: inputNum, inputNum2: inputNum2, outputNum: convertedOutput)

        }
        else if unitType == 4 //temp
        {
            convertedOutput = tempConverter(inputUnit: inputUnit, outputUnit: outputUnit, inputNum: inputNum) + tempConverter(inputUnit: inputUnit2, outputUnit: outputUnit, inputNum: inputNum2)
            addMultiHistoryItem(inputUnitW: GlobalData.tempSymbol[inputUnit], inputUnitW2: GlobalData.tempSymbol[inputUnit2], outputUnitW: GlobalData.tempSymbol[outputUnit], inputNum: inputNum, inputNum2: inputNum2, outputNum: convertedOutput)

        }
        else if unitType == 5 //time
        {
            convertedOutput = timeConverter(inputUnit: inputUnit, outputUnit: outputUnit, inputNum: inputNum) + timeConverter(inputUnit: inputUnit2, outputUnit: outputUnit, inputNum: inputNum2)
            addMultiHistoryItem(inputUnitW: GlobalData.timeSymbol[inputUnit], inputUnitW2: GlobalData.timeSymbol[inputUnit2], outputUnitW: GlobalData.timeSymbol[outputUnit], inputNum: inputNum, inputNum2: inputNum2, outputNum: convertedOutput)

        }
        else if unitType == 6 //volume
        {
            convertedOutput = volumeConverter(inputUnit: inputUnit, outputUnit: outputUnit, inputNum: inputNum) + volumeConverter(inputUnit: inputUnit2, outputUnit: outputUnit, inputNum: inputNum2)
            addMultiHistoryItem(inputUnitW: GlobalData.volumeSymbol[inputUnit], inputUnitW2: GlobalData.volumeSymbol[inputUnit2], outputUnitW: GlobalData.volumeSymbol[outputUnit], inputNum: inputNum, inputNum2: inputNum2, outputNum: convertedOutput)

        }
        else if unitType == 7 //force
        {
            convertedOutput = forceConverter(inputUnit: inputUnit, outputUnit: outputUnit, inputNum: inputNum) + forceConverter(inputUnit: inputUnit2, outputUnit: outputUnit, inputNum: inputNum2)
            addMultiHistoryItem(inputUnitW: GlobalData.forceSymbol[inputUnit], inputUnitW2: GlobalData.forceSymbol[inputUnit2], outputUnitW: GlobalData.forceSymbol[outputUnit], inputNum: inputNum, inputNum2: inputNum2, outputNum: convertedOutput)

        }
        else if unitType == 8 //angles
        {
            convertedOutput = angleConverter(inputUnit: inputUnit, outputUnit: outputUnit, inputNum: inputNum) + angleConverter(inputUnit: inputUnit2, outputUnit: outputUnit, inputNum: inputNum2)
            addMultiHistoryItem(inputUnitW: GlobalData.angleSymbol[inputUnit], inputUnitW2: GlobalData.angleSymbol[inputUnit2], outputUnitW: GlobalData.angleSymbol[outputUnit], inputNum: inputNum, inputNum2: inputNum2, outputNum: convertedOutput)
        }
        else if unitType == 9 //num systems
        {
            //tbd
        }
        else //no unit selected
        {
            print("ERROR: conversion with out inputs")
        }
        return convertedOutput
        
    }

    func lengthConverter(inputUnit:Int,outputUnit:Int,inputNum:Double) -> Double{
        var convertedLength:Double = inputNum
        
        //Firstly, based on the inputUnit, convert the inputNum into metres
        if inputUnit == 0{//micrometers to meters
            convertedLength = convertedLength * 0.000001
        }
        else if inputUnit == 1{//millimeters to meters
            convertedLength = convertedLength * 0.001
        }
        else if inputUnit == 2{//centimeters to meters
            convertedLength = convertedLength * 0.01
        }
        //inputUnit = 3 is meters to meters
        else if inputUnit == 4{//kilometers to meters
            convertedLength = convertedLength * 1000
        }
        else if inputUnit == 5{//inches to meters
            convertedLength = convertedLength * 0.0254
        }
        else if inputUnit == 6{//feet to meters
            convertedLength = convertedLength * 0.3048
        }
        else if inputUnit == 7{//yards to meters
            convertedLength = convertedLength * 0.9144
        }
        else if inputUnit == 8{//mile to meters
            convertedLength = convertedLength * 1609.35
        }
        else if inputUnit == 9{//nautical mile to meters
            convertedLength = convertedLength * 1852
        }
        else if inputUnit == 10{//football to meters
            convertedLength = convertedLength * 91.44
        }
        else if inputUnit == 11{//marathons to meters
            convertedLength = convertedLength * 42195
        }
        else if inputUnit == 12{//furlong to meters
            convertedLength = convertedLength * 201
        }
        else if inputUnit == 13{//hammer units to meters
            convertedLength = convertedLength * 0.01905
        }
        
        //Next, based on outputUnit, convert the inputNum from meters into desired output unit
        if outputUnit == 0{//meters to micrometers
            convertedLength = convertedLength * 1000000
        }
        else if outputUnit == 1{//meters to millimeters
            convertedLength = convertedLength * 1000
        }
        else if outputUnit == 2{//meters to centimeters
            convertedLength = convertedLength * 100
        }
        //outputUnit = 3 is meters to meters
        else if outputUnit == 4{//meters to kilometers
            convertedLength = convertedLength * 0.001
        }
        else if outputUnit == 5{//meters to inches
            convertedLength = convertedLength * 39.37007874
        }
        else if outputUnit == 6{//meters to feet
            convertedLength = convertedLength * 3.280839895
        }
        else if outputUnit == 7{//meters to yards
            convertedLength = convertedLength * 1.0936132983
        }
        else if outputUnit == 8{//meters to miles
            convertedLength = convertedLength * 0.0006213689
        }
        else if outputUnit == 9{//meters to nautical miles
            convertedLength = convertedLength * 0.0005399568
        }
        else if outputUnit == 10{//meters to football fields
            convertedLength = convertedLength * 0.010936
        }
        else if outputUnit == 11{//meters to marathons
            convertedLength = convertedLength * 0.000023709
        }
        else if outputUnit == 12{//meters to furlongs
            convertedLength = convertedLength * 0.004975
        }
        else if outputUnit == 12{//meters to hammer units
            convertedLength = convertedLength * 52.356
        }
        return convertedLength
    }

    func massConverter(inputUnit:Int,outputUnit:Int,inputNum:Double) -> Double{
        var convertedMass:Double = inputNum
        
        //Firstly, based on the inputUnit, convert the inputNum into grams
        if inputUnit == 0{//milligrams to grams
            convertedMass = convertedMass * 0.001
        }
        //inputUnit == 1 is grams to grams
        else if inputUnit == 2{//kilograms to grams
            convertedMass = convertedMass * 1000
        }
        else if inputUnit == 3{//metric ton to grams
            convertedMass = convertedMass * 1000000
        }
        else if inputUnit == 4{//ounce to grams
            convertedMass = convertedMass * 28.3495
        }
        else if inputUnit == 5{//pounds to grams
            convertedMass = convertedMass * 453.592
        }
        else if inputUnit == 6{//long ton to grams
            convertedMass = convertedMass * 1016046.08
        }
        else if inputUnit == 7{//short ton to grams
            convertedMass = convertedMass * 907184
        }
        else if inputUnit == 8{//firkins to grams
            convertedMass = convertedMass * 25401.17272
        }
        else if inputUnit == 9{//bricks to grams
            convertedMass = convertedMass * 3100
        }
        else if inputUnit == 10{//loonies to grams
            convertedMass = convertedMass * 6.998
        }
        
        //Next, based on output unit,convert the inputNum from grams into desired unit
        if outputUnit == 0{//grams to milligrams
            convertedMass = convertedMass * 1000
        }
        //outputUnit == 1 is grams to grams
        else if outputUnit == 2{//grams to kilograms
            convertedMass = convertedMass * 0.001
        }
        else if outputUnit == 3{//grams to metric ton
            convertedMass = convertedMass * 0.000001
        }
        else if outputUnit == 4{//grams to ounce
            convertedMass = convertedMass * 0.0352739907
        }
        else if outputUnit == 5{//grams to pounds
            convertedMass = convertedMass * 0.0022046244
        }
        else if outputUnit == 6{//grams to long ton
            convertedMass = convertedMass * 0.00000009842073304
        }
        else if outputUnit == 7{//grams to short ton
            convertedMass = convertedMass * 0.0000011023
        }
        else if outputUnit == 8{//grams to firkins
            convertedMass = convertedMass * 0.00003936838
        }
        else if outputUnit == 9{//grams to bricks
            convertedMass = convertedMass * 0.00032258
        }
        else if outputUnit == 10{//grams to loonies
            convertedMass = convertedMass * 0.142914546441983
        }
        
        return convertedMass
    }

    func speedConverter(inputUnit:Int,outputUnit:Int,inputNum:Double) -> Double{
        var convertedSpeed = inputNum
        
        //Firstly, based on the inputUnit, convert the inputNum into km/hr
        if inputUnit == 0{//m/s to km/hr
            convertedSpeed = convertedSpeed * 3.6
        }
        else if inputUnit == 1{// m/m to km/hr
            convertedSpeed = convertedSpeed * 0.06
        }
        else if inputUnit == 2{// m/hr to km/hr
            convertedSpeed = convertedSpeed * 0.001
        }
        else if inputUnit == 3{// km/s to km/hr
            convertedSpeed = convertedSpeed * 3600
        }
        else if inputUnit == 4{// km/m to km/hr
            convertedSpeed = convertedSpeed * 60
        }
        // 5 is km/hr to km/hr
        else if inputUnit == 6{// ft/s to km/hr
            convertedSpeed = convertedSpeed * 1.09728
        }
        else if inputUnit == 7{// miles/hr to km/hr
            convertedSpeed = convertedSpeed * 1.609344
        }
        else if inputUnit == 8{// knots to km/hr
            convertedSpeed = convertedSpeed * 1.852
        }
        else if inputUnit == 9{// light years to km/hr
            convertedSpeed = convertedSpeed * 94688221709.6317
        }
        else if inputUnit == 10{// beard seconds to km/hr
            convertedSpeed = convertedSpeed * 0.02778
        }
        else if inputUnit == 11{// Hammer units / second to km/hr
            convertedSpeed = convertedSpeed * 0.06858125
        }
        
        //Next, based on output unit,convert the inputNum from grams into desired unit
        if outputUnit == 0{//km/hr to m/s
            convertedSpeed = convertedSpeed * 0.2777777778
        }
        else if outputUnit == 1{//km/hr to m/m
            convertedSpeed = convertedSpeed * 16.666666667
        }
        else if outputUnit == 2{//km/hr to m/hr
            convertedSpeed = convertedSpeed * 1000
        }
        else if outputUnit == 3{//km/hr to km/s
            convertedSpeed = convertedSpeed * 0.0002777778
        }
        else if outputUnit == 4{//km/hr to km/m
            convertedSpeed = convertedSpeed * 16.666666667
        }
        //5 is km/hr to km/hr
        else if outputUnit == 6{//km/hr to ft/s
            convertedSpeed = convertedSpeed * 0.9113444153
        }
        else if outputUnit == 7{//km/hr to mile/hr
            convertedSpeed = convertedSpeed * 0.6213711922
        }
        else if outputUnit == 8{//km/hr to knot
            convertedSpeed = convertedSpeed * 0.5399568035
        }
        else if outputUnit == 9{//km/hr to light years
            convertedSpeed = convertedSpeed * 0.00000000000010570
        }
        else if outputUnit == 10{//km/hr to beard seconds
            convertedSpeed = convertedSpeed * 36
        }
        else if outputUnit == 11{//km/hr to hammer units per second
            convertedSpeed = convertedSpeed * 14.574
        }

        return convertedSpeed
    }

    func tempConverter(inputUnit:Int,outputUnit:Int,inputNum:Double) -> Double{
        var convertedTemp:Double = inputNum
        
        //first, based on the inputUnit,convert inputNum into celsius
        //inputUnit 0 already celsius
        if inputUnit == 1{//farenheit to celsisus
            convertedTemp = (convertedTemp - 32) / 1.8
        }
        else if inputUnit == 2{//kelvin to celsisus
            convertedTemp = convertedTemp - 273.15
        }
        else if inputUnit == 3{//rakine to celsisus
            convertedTemp = (convertedTemp / 1.8 ) - 273.15
        }
        //next, based on outputUnit, convert inputNum into desired unit
        //outputUnit 0 already in celsius
        if outputUnit == 1{//celsius to farenheit
            convertedTemp = (convertedTemp * 1.8) + 32
        }
        else if outputUnit == 2{//celsius to kelvin
            convertedTemp = convertedTemp + 273.15
        }
        else if outputUnit == 3{//celsius to rakine
            convertedTemp = (convertedTemp * 1.8) + 491.67
        }
        
        return convertedTemp
    }

    func timeConverter(inputUnit:Int,outputUnit:Int,inputNum:Double) -> Double{
        var convertedTime:Double = inputNum
        
        //first, based on the inputUnit, convert inputNum into Minutes
        if inputUnit == 0{//millisecond to minutes
            convertedTime = convertedTime * 0.0000166667
        }
        else if inputUnit == 1{//second to minutes
            convertedTime = convertedTime * 0.0166666667
        }
        //inputUnit 2 is min to min
        else if inputUnit == 3{//hour to minutes
            convertedTime = convertedTime * 60
        }
        else if inputUnit == 4{//week to minutes
            convertedTime = convertedTime * 10080
        }
        else if inputUnit == 5{//year to minutes
            convertedTime = convertedTime * 525960
        }
        else if inputUnit == 6{//jiffy to minutes
            convertedTime = convertedTime * 0.00000000000055593333333337
        }
        else if inputUnit == 7{//nanocentury to minutes
            convertedTime = convertedTime * 0.0526
        }
        else if inputUnit == 8{//fortnight to minutes
            convertedTime = convertedTime * 20160
        }
        //Next, based on outputUnit, convert inputNum into desired unit
        if outputUnit == 0{//minutes to milliseconds
            convertedTime = convertedTime * 60000
        }
        else if outputUnit == 1{//minutes to seconds
            convertedTime = convertedTime * 60
        }
        //outputUnit 2 is min to min
        else if outputUnit == 3{//minutes to hours
            convertedTime = convertedTime * 0.0166666667
        }
        else if outputUnit == 4{//minutes to weeks
            convertedTime = convertedTime * 0.0000992063
        }
        else if outputUnit == 5{//minutes to years
            convertedTime = convertedTime * 0.0000019013
        }
        else if outputUnit == 6{//minutes to jiffy
            convertedTime = convertedTime * 1798776831754.3
        }
        else if outputUnit == 7{//minutes to nanocentury
            convertedTime = convertedTime * 19.01
        }
        else if outputUnit == 8{//minutes to fortnight
            convertedTime = convertedTime * 0.0000496
        }
        return convertedTime
    }

    func volumeConverter(inputUnit:Int,outputUnit:Int,inputNum:Double) -> Double{
        var convertedVolume = inputNum
        
        //First, based on inputUnit, convert inputNum into litres
        if inputUnit == 0{//milliliter to litre
            convertedVolume = convertedVolume * 0.001
        }
        //inputUnit == 1 is litre to litre
        else if inputUnit == 2{//gallon to litre
            convertedVolume = convertedVolume * 3.785411784
        }
        else if inputUnit == 3{//pint to litre
            convertedVolume = convertedVolume * 0.473176473
        }
        else if inputUnit == 4{//quart to litre
            convertedVolume = convertedVolume * 0.946352946
        }
        else if inputUnit == 5{//cup to litre
            convertedVolume = convertedVolume * 0.2365882365
        }
        else if inputUnit == 6{//standard shots to litre
            convertedVolume = convertedVolume * 0.0444
        }
        else if inputUnit == 7{//standard cans to litre
            convertedVolume = convertedVolume * 0.355
        }
        //Next, based on outputUnit, convert inputNum into desired unit
        if outputUnit == 0{//litres to millilitres
            convertedVolume = convertedVolume * 1000
        }
        //outputUnit = 1 is litres to litres
        else if outputUnit == 2{//litres to gallons
            convertedVolume = convertedVolume * 0.2641720524
        }
        else if outputUnit == 3{//litres to pint
            convertedVolume = convertedVolume * 2.1133764189
        }
        else if outputUnit == 3{//litres to quart
            convertedVolume = convertedVolume * 1.0566882094
        }
        else if outputUnit == 4{//litres to cup
            convertedVolume = convertedVolume * 4.2267528377
        }
        else if outputUnit == 5{//litres to standard shot
            convertedVolume = convertedVolume * 22.5225
        }
        else if outputUnit == 6{//litres to standard shot
            convertedVolume = convertedVolume * 0.0444
        }
        
        return convertedVolume
    }

    func forceConverter(inputUnit:Int,outputUnit:Int,inputNum:Double) -> Double{
        var convertedForce = inputNum
        
        //First, based on inputUnit, convert inputNum into newtons
        //inputUnit 0 is newtons to newtons
        if inputUnit == 1{//kilonewton to newtons
            convertedForce = convertedForce * 1000
        }
        else if inputUnit == 2{//dyne to newtons
            convertedForce = convertedForce * 0.00001
        }
        else if inputUnit == 3{//pond to newtons
            convertedForce = convertedForce * 0.00980665
        }
        else if inputUnit == 4{//kilopond to newtons
            convertedForce = convertedForce * 9.80665
        }
        else if inputUnit == 5{//ounce force to newtons
            convertedForce = convertedForce * 0.278013851
        }
        else if inputUnit == 6{//pound force to newtons
            convertedForce = convertedForce * 4.4482216153
        }
        else if inputUnit == 7{//poundal to newtons
            convertedForce = convertedForce * 0.1382549544
        }
        //Next, based on outputUnit, convert inputNum into desired unit
        //outoutUnit 0 is newtons to newtons
        if outputUnit == 1{//newtons to kilonewtons
            convertedForce = convertedForce * 0.001
        }
        else if outputUnit == 2{//newtons to dynes
            convertedForce = convertedForce * 100000
        }
        else if outputUnit == 3{//newtons to pond
            convertedForce = convertedForce * 101.9716213
        }
        else if outputUnit == 4{//newtons to kilopond
            convertedForce = convertedForce * 0.1019716213
        }
        else if outputUnit == 5{//newtons to ounce force
            convertedForce = convertedForce * 3.5969430896
        }
        else if outputUnit == 6{//newtons to pound force
            convertedForce = convertedForce * 0.2248089431
        }
        else if outputUnit == 7{//newtons to poundal
            convertedForce = convertedForce * 7.2330138512
        }
        
        return convertedForce
    }
    
    func angleConverter(inputUnit:Int,outputUnit:Int,inputNum:Double) -> Double{
        if inputUnit == 0 && outputUnit == 1 { 
                return inputNum * .pi / 180
            } else if inputUnit == 1 && outputUnit == 0 {
                // Convert radians to degrees
                return inputNum * 180 / .pi
            } else {
                // No conversion needed, return input as is
                return inputNum
            }
        }
    
    func addHistoryItem(inputUnitW: String, outputUnitW: String, inputNum: Double, outputNum: Double) {
        if userSettings.showHistoryTab{
            let formatter = NumberFormatter() //dynamic number formatter made for this local scope
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 3
            
            let formattedInputNum = formatter.string(from: NSNumber(value: inputNum)) ?? ""
            let formattedOutputNum = formatter.string(from: NSNumber(value: outputNum)) ?? ""
            
            let item = HistoryItem(historyText: "\(formattedInputNum) \(inputUnitW) = \(formattedOutputNum) \(outputUnitW)")
            
            context.insert(item)
        }
    }
    
    func addMultiHistoryItem(inputUnitW: String,inputUnitW2: String, outputUnitW: String, inputNum: Double, inputNum2: Double, outputNum: Double) {
        if userSettings.showHistoryTab{
            let formatter = NumberFormatter() //dynamic number formatter made for this local scope
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 3
            
            let formattedInputNum = formatter.string(from: NSNumber(value: inputNum)) ?? ""
            let formattedInputNum2 = formatter.string(from: NSNumber(value: inputNum2)) ?? ""
            let formattedOutputNum = formatter.string(from: NSNumber(value: outputNum)) ?? ""
            
            let item = HistoryItem(historyText: "\(formattedInputNum) \(inputUnitW) + \(formattedInputNum2) \(inputUnitW2) = \(formattedOutputNum) \(outputUnitW)")
            
            context.insert(item)
        }
    }
    
    var body: some View {
        VStack {
            Text("Converter")
                .myTextStyle(.title)
                .frame(maxWidth: .infinity, alignment: .leading) // Ensure left alignment
            Spacer()

            // Picker that selects system of unit
            ZStack{
                // Fill color
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width:180, height: 35)
                        .foregroundColor(Color("BoxFillColors"))
                        .padding()

                    // Stroke color
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color("BoxStrokeColors"))
                        .frame(width:180, height: 35)
                        .padding() // Adjust padding as needed
                
                Picker("Select Unit Type", selection: $selectedUnitIndex) {
                    ForEach(Array(GlobalData.unitSystems.enumerated()), id: \.offset) { index, unit in
                        Text(unit)
                    }
                }
                .onChange(of: selectedUnitIndex) { newValue, _ in
                    resetSelectedIndices()
                }
                .pickerStyle(DefaultPickerStyle())
                .padding()
                
            }
            
            
            HStack{
                //Visual stack for input box and unit selection for input
                Spacer()
                //textfield for first input
                TextField("Enter Number", value: $inputValue, formatter: NumberFormatter().decimalNumberFormatter)
                    .frame(height: 35)
                    .background(Color("BoxFillColors")) // Apply BoxColors to the background
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10) // Add overlay for stroke
                            .stroke(Color("BoxStrokeColors")) // Apply plain black color to the stroke
                    )

                //Switch for deciding which unit array for input 1
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 35)
                    .foregroundColor(Color("BoxFillColors")) // Apply BoxColors to the fill color
                    .overlay(
                        RoundedRectangle(cornerRadius: 10) // Add another RoundedRectangle for stroke
                            .stroke(Color("BoxStrokeColors")) // Apply plain black color to the stroke
                    )
                    .overlay(
                // Switch for deciding which unit array for input 1
                    Group {
                        switch selectedUnitIndex{
                        case 1:
                            if userSettings.toggleFictionalUnits{
                                Picker("Select Unit", selection: $selectedUnitIndex2){
                                    ForEach(Array(GlobalData.lengthUnit.enumerated()), id: \.offset) { index, unit in
                                        Text(unit)
                                    }
                                }
                            }
                            else{
                                Picker("Select Unit", selection: $selectedUnitIndex2) {
                                    ForEach(0..<GlobalData.lengthUnit.count - 4, id: \.self) { index in
                                        let unit = GlobalData.lengthUnit[index]
                                        Text(unit)
                                    }
                                }
                            }
                        case 2:
                            if userSettings.toggleFictionalUnits{
                                Picker("Select Unit", selection: $selectedUnitIndex2){
                                    ForEach(Array(GlobalData.massUnit.enumerated()), id: \.offset) { index, unit in
                                        Text(unit)
                                    }
                                }
                            }
                            else{
                                Picker("Select Unit", selection: $selectedUnitIndex2) {
                                    ForEach(0..<GlobalData.massUnit.count - 3, id: \.self) { index in
                                        let unit = GlobalData.massUnit[index]
                                        Text(unit)
                                    }
                                }
                            }
                        case 3:
                            if userSettings.toggleFictionalUnits{
                                Picker("Select Unit", selection: $selectedUnitIndex2){
                                    ForEach(Array(GlobalData.speedUnit.enumerated()), id: \.offset) { index, unit in
                                        Text(unit)
                                    }
                                }
                            }
                            else{
                                Picker("Select Unit", selection: $selectedUnitIndex2) {
                                    ForEach(0..<GlobalData.speedUnit.count - 3, id: \.self) { index in
                                        let unit = GlobalData.speedUnit[index]
                                        Text(unit)
                                    }
                                }
                            }
                        case 4:
                            Picker("Select Unit", selection: $selectedUnitIndex2){
                                ForEach(Array(GlobalData.tempUnit.enumerated()), id: \.offset) { index, unit in
                                    Text(unit)
                                }
                            }
                        case 5:
                            if userSettings.toggleFictionalUnits{
                                Picker("Select Unit", selection: $selectedUnitIndex2){
                                    ForEach(Array(GlobalData.timeUnit.enumerated()), id: \.offset) { index, unit in
                                        Text(unit)
                                    }
                                }
                            }
                            else{
                                Picker("Select Unit", selection: $selectedUnitIndex2) {
                                    ForEach(0..<GlobalData.timeUnit.count - 3, id: \.self) { index in
                                        let unit = GlobalData.timeUnit[index]
                                        Text(unit)
                                    }
                                }
                            }
                        case 6:
                            if userSettings.toggleFictionalUnits{
                                Picker("Select Unit", selection: $selectedUnitIndex2){
                                    ForEach(Array(GlobalData.volumeUnit.enumerated()), id: \.offset) { index, unit in
                                        Text(unit)
                                    }
                                }
                            }
                            else{
                                Picker("Select Unit", selection: $selectedUnitIndex2) {
                                    ForEach(0..<GlobalData.volumeUnit.count - 2, id: \.self) { index in
                                        let unit = GlobalData.volumeUnit[index]
                                        Text(unit)
                                    }
                                }
                            }
                        case 7:
                            Picker("Select Unit", selection: $selectedUnitIndex2){
                                ForEach(Array(GlobalData.forceUnit.enumerated()), id: \.offset) { index, unit in
                                    Text(unit)
                                }
                                
                            }
                        case 8:
                            Picker("Select Unit", selection: $selectedUnitIndex2){
                                ForEach(Array(GlobalData.angleUnit.enumerated()), id: \.offset) { index, unit in
                                    Text(unit)
                                }
                                
                            }
                        case 9:
                            Picker("Select Unit", selection: $selectedUnitIndex2){
                                ForEach(Array(GlobalData.numberSystem.enumerated()), id: \.offset) { index, unit in
                                    Text(unit)
                                }
                                
                            }
                        default:
                            Text("Select a Unit Type")
                        }
                    }
                )
                
                Spacer()
            }
            if $multiConvert.wrappedValue{
                Text("+")
                    .font(.system(size: 24))
                HStack{
                    Spacer()

                    TextField("Enter Number", value: $inputValue2, formatter: NumberFormatter().decimalNumberFormatter)
                        .frame(height: 35)
                        .background(Color("BoxFillColors")) // Apply BoxColors to the background
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10) // Add overlay for stroke
                                .stroke(Color("BoxStrokeColors")) // Apply plain black color to the stroke
                        )

                    //Switch for deciding which unit array for input 2
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 35)
                        .foregroundColor(Color("BoxFillColors")) // Apply BoxColors to the fill color
                        .overlay(
                            RoundedRectangle(cornerRadius: 10) // Add another RoundedRectangle for stroke
                                .stroke(Color("BoxStrokeColors")) // Apply plain black color to the stroke
                        )
                        .overlay(
                    // Switch for deciding which unit array for input 1
                            Group {
                                switch selectedUnitIndex{
                                case 1:
                                    if userSettings.toggleFictionalUnits{
                                        Picker("Select Unit", selection: $selectedUnitIndex4){
                                            ForEach(Array(GlobalData.lengthUnit.enumerated()), id: \.offset) { index, unit in
                                                Text(unit)
                                            }
                                        }
                                    }
                                    else{
                                        Picker("Select Unit", selection: $selectedUnitIndex4) {
                                            ForEach(0..<GlobalData.lengthUnit.count - 4, id: \.self) { index in
                                                let unit = GlobalData.lengthUnit[index]
                                                Text(unit)
                                            }
                                        }
                                    }
                                case 2:
                                    if userSettings.toggleFictionalUnits{
                                        Picker("Select Unit", selection: $selectedUnitIndex4){
                                            ForEach(Array(GlobalData.massUnit.enumerated()), id: \.offset) { index, unit in
                                                Text(unit)
                                            }
                                        }
                                    }
                                    else{
                                        Picker("Select Unit", selection: $selectedUnitIndex4) {
                                            ForEach(0..<GlobalData.massUnit.count - 3, id: \.self) { index in
                                                let unit = GlobalData.massUnit[index]
                                                Text(unit)
                                            }
                                        }
                                    }
                                case 3:
                                    if userSettings.toggleFictionalUnits{
                                        Picker("Select Unit", selection: $selectedUnitIndex4){
                                            ForEach(Array(GlobalData.speedUnit.enumerated()), id: \.offset) { index, unit in
                                                Text(unit)
                                            }
                                        }
                                    }
                                    else{
                                        Picker("Select Unit", selection: $selectedUnitIndex4) {
                                            ForEach(0..<GlobalData.speedUnit.count - 3, id: \.self) { index in
                                                let unit = GlobalData.speedUnit[index]
                                                Text(unit)
                                            }
                                        }
                                    }
                                case 4:
                                    Picker("Select Unit", selection: $selectedUnitIndex4){
                                        ForEach(Array(GlobalData.tempUnit.enumerated()), id: \.offset) { index, unit in
                                            Text(unit)
                                        }
                                    }
                                case 5:
                                    if userSettings.toggleFictionalUnits{
                                        Picker("Select Unit", selection: $selectedUnitIndex4){
                                            ForEach(Array(GlobalData.timeUnit.enumerated()), id: \.offset) { index, unit in
                                                Text(unit)
                                            }
                                        }
                                    }
                                    else{
                                        Picker("Select Unit", selection: $selectedUnitIndex4) {
                                            ForEach(0..<GlobalData.timeUnit.count - 3, id: \.self) { index in
                                                let unit = GlobalData.timeUnit[index]
                                                Text(unit)
                                            }
                                        }
                                    }
                                case 6:
                                    if userSettings.toggleFictionalUnits{
                                        Picker("Select Unit", selection: $selectedUnitIndex4){
                                            ForEach(Array(GlobalData.volumeUnit.enumerated()), id: \.offset) { index, unit in
                                                Text(unit)
                                            }
                                        }
                                    }
                                    else{
                                        Picker("Select Unit", selection: $selectedUnitIndex4) {
                                            ForEach(0..<GlobalData.volumeUnit.count - 2, id: \.self) { index in
                                                let unit = GlobalData.volumeUnit[index]
                                                Text(unit)
                                            }
                                        }
                                    }
                                case 7:
                                    Picker("Select Unit", selection: $selectedUnitIndex4){
                                        ForEach(Array(GlobalData.forceUnit.enumerated()), id: \.offset) { index, unit in
                                            Text(unit)
                                        }
                                        
                                    }
                                case 8:
                                    Picker("Select Unit", selection: $selectedUnitIndex4){
                                        ForEach(Array(GlobalData.angleUnit.enumerated()), id: \.offset) { index, unit in
                                            Text(unit)
                                        }
                                        
                                    }
                                case 9:
                                    Picker("Select Unit", selection: $selectedUnitIndex4){
                                        ForEach(Array(GlobalData.numberSystem.enumerated()), id: \.offset) { index, unit in
                                            Text(unit)
                                        }
                                        
                                    }
                                default:
                                    Text("Select a Unit Type")
                                }
                            }
                        )
                    Spacer()
                }
            }
            VStack{
                Text("=")
                    .font(.system(size: 24))
            }
            
            HStack{
                //Visual stack for output box and unit selection for output
                Spacer()
                ZStack {
                    HStack{
                        Text("Your output is \(output)")
                            .modifier(DynamicNumberFormat(number: output))
                        switch selectedUnitIndex {
                        case 1:
                            if selectedUnitIndex3 < GlobalData.lengthSymbol.count {
                                Text("\(GlobalData.lengthSymbol[selectedUnitIndex3])")
                            } else {
                                Text("")
                            }
                        case 2:
                            if selectedUnitIndex3 < GlobalData.massSymbol.count {
                                Text("\(GlobalData.massSymbol[selectedUnitIndex3])")
                            } else {
                                Text("")
                            }
                        case 3:
                            if selectedUnitIndex3 < GlobalData.speedSymbol.count {
                                Text("\(GlobalData.speedSymbol[selectedUnitIndex3])")
                            } else {
                                Text("")
                            }
                        case 4:
                            if selectedUnitIndex3 < GlobalData.tempSymbol.count {
                                Text("\(GlobalData.tempSymbol[selectedUnitIndex3])")
                            } else {
                                Text("")
                            }
                        case 5:
                            if selectedUnitIndex3 < GlobalData.timeSymbol.count {
                                Text("\(GlobalData.timeSymbol[selectedUnitIndex3])")
                            } else {
                                Text("")
                            }
                        case 6:
                            if selectedUnitIndex3 < GlobalData.volumeSymbol.count {
                                Text("\(GlobalData.volumeSymbol[selectedUnitIndex3])")
                            } else {
                                Text("")
                            }
                        case 7:
                            if selectedUnitIndex3 < GlobalData.forceSymbol.count {
                                Text("\(GlobalData.forceSymbol[selectedUnitIndex3])")
                            } else {
                                Text("")
                            }
                        case 8:
                            if selectedUnitIndex3 < GlobalData.angleSymbol.count {
                                Text("\(GlobalData.angleSymbol[selectedUnitIndex3])")
                            } else {
                                Text("")
                            }
                        case 9:
                            if selectedUnitIndex3 < GlobalData.numberSystem.count {
                                Text("\(GlobalData.numberSystem[selectedUnitIndex3])")
                            } else {
                                Text("")
                            }
                        default:
                            Text("")
                        }
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("BoxStrokeColors"))
                            .frame(width: 170, height: 35) // Adjust width and height to accommodate the text's frame and padding
                            .foregroundColor(Color("BoxFillColors"))
                    } // Set a fixed width for the output text box
                //switch for text displaying the unit symbol for the output
                
                
                //Switch for deciding which unit array for output
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 35)
                    .foregroundColor(Color("BoxFillColors")) // Apply BoxColors to the fill color
                    .overlay(
                        RoundedRectangle(cornerRadius: 10) // Add another RoundedRectangle for stroke
                            .stroke(Color("BoxStrokeColors")) // Apply plain black color to the stroke
                    )
                    .overlay(
                // Switch for deciding which unit array for input 1
                        Group {
                            switch selectedUnitIndex{
                            case 1:
                                if userSettings.toggleFictionalUnits{
                                    Picker("Select Unit", selection: $selectedUnitIndex3){
                                        ForEach(Array(GlobalData.lengthUnit.enumerated()), id: \.offset) { index, unit in
                                            Text(unit)
                                        }
                                    }
                                }
                                else{
                                    Picker("Select Unit", selection: $selectedUnitIndex3) {
                                        ForEach(0..<GlobalData.lengthUnit.count - 4, id: \.self) { index in
                                            let unit = GlobalData.lengthUnit[index]
                                            Text(unit)
                                        }
                                    }
                                }
                            case 2:
                                if userSettings.toggleFictionalUnits{
                                    Picker("Select Unit", selection: $selectedUnitIndex3){
                                        ForEach(Array(GlobalData.massUnit.enumerated()), id: \.offset) { index, unit in
                                            Text(unit)
                                        }
                                    }
                                }
                                else{
                                    Picker("Select Unit", selection: $selectedUnitIndex3) {
                                        ForEach(0..<GlobalData.massUnit.count - 3, id: \.self) { index in
                                            let unit = GlobalData.massUnit[index]
                                            Text(unit)
                                        }
                                    }
                                }
                            case 3:
                                if userSettings.toggleFictionalUnits{
                                    Picker("Select Unit", selection: $selectedUnitIndex3){
                                        ForEach(Array(GlobalData.speedUnit.enumerated()), id: \.offset) { index, unit in
                                            Text(unit)
                                        }
                                    }
                                }
                                else{
                                    Picker("Select Unit", selection: $selectedUnitIndex3) {
                                        ForEach(0..<GlobalData.speedUnit.count - 3, id: \.self) { index in
                                            let unit = GlobalData.speedUnit[index]
                                            Text(unit)
                                        }
                                    }
                                }
                            case 4:
                                Picker("Select Unit", selection: $selectedUnitIndex3){
                                    ForEach(Array(GlobalData.tempUnit.enumerated()), id: \.offset) { index, unit in
                                        Text(unit)
                                    }
                                }
                            case 5:
                                if userSettings.toggleFictionalUnits{
                                    Picker("Select Unit", selection: $selectedUnitIndex3){
                                        ForEach(Array(GlobalData.timeUnit.enumerated()), id: \.offset) { index, unit in
                                            Text(unit)
                                        }
                                    }
                                }
                                else{
                                    Picker("Select Unit", selection: $selectedUnitIndex3) {
                                        ForEach(0..<GlobalData.timeUnit.count - 3, id: \.self) { index in
                                            let unit = GlobalData.timeUnit[index]
                                            Text(unit)
                                        }
                                    }
                                }
                            case 6:
                                if userSettings.toggleFictionalUnits{
                                    Picker("Select Unit", selection: $selectedUnitIndex3){
                                        ForEach(Array(GlobalData.volumeUnit.enumerated()), id: \.offset) { index, unit in
                                            Text(unit)
                                        }
                                    }
                                }
                                else{
                                    Picker("Select Unit", selection: $selectedUnitIndex3) {
                                        ForEach(0..<GlobalData.volumeUnit.count - 2, id: \.self) { index in
                                            let unit = GlobalData.volumeUnit[index]
                                            Text(unit)
                                        }
                                    }
                                }
                            case 7:
                                Picker("Select Unit", selection: $selectedUnitIndex3){
                                    ForEach(Array(GlobalData.forceUnit.enumerated()), id: \.offset) { index, unit in
                                        Text(unit)
                                    }
                                    
                                }
                            case 8:
                                Picker("Select Unit", selection: $selectedUnitIndex3){
                                    ForEach(Array(GlobalData.angleUnit.enumerated()), id: \.offset) { index, unit in
                                        Text(unit)
                                    }
                                    
                                }
                            case 9:
                                Picker("Select Unit", selection: $selectedUnitIndex3){
                                    ForEach(Array(GlobalData.numberSystem.enumerated()), id: \.offset) { index, unit in
                                        Text(unit)
                                    }
                                    
                                }
                            default:
                                Text("Select a Unit Type")
                            }
                        }
                    )
                Spacer()
            }
            
            HStack{
                //Visual stack for button that clears input and toggle dual input
                Button(action: { //trash icon button to clear all inputs
                                selectedUnitIndex = 0
                                selectedUnitIndex2 = 0
                                selectedUnitIndex3 = 0
                                selectedUnitIndex4 = 0
                                inputValue = 0
                                inputValue2 = 0
                                output = 0

                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(Color.accentColor) // Customize the color if needed
                                    .font(.title) // Adjust the size if needed
                            }
                            .padding()
                
                //area for dual input toggle
                if userSettings.toggleMultiConvert{
                    Toggle("", isOn: $multiConvert)
                        .padding(.horizontal)
                }
            }
            Button(action: {
                // Calculate value of conversion
                if $multiConvert.wrappedValue {
                    output = buttonPressMultiConvert(unitType: selectedUnitIndex, inputUnit: selectedUnitIndex2, inputUnit2: selectedUnitIndex4, outputUnit: selectedUnitIndex3, inputNum: inputValue, inputNum2: inputValue2)
                } else {
                    output = buttonPressConvert(unitType: selectedUnitIndex, inputUnit: selectedUnitIndex2, outputUnit: selectedUnitIndex3, inputNum: inputValue)
                }
            }) {
                Text("Convert")
            }
            .buttonStyle(MyButtonStyle())
            Spacer()

        }
        .padding()
//        .background(Color("BackgroundColor"))
                .background(
                    Color.white.opacity(0.0001) // colour makes it so tap gesture works, dont question it
                        .onTapGesture { //dismisses keyboard when user taps anywheres but text field
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                )
    }
    
}
