//
//  ConverterView.swift
//  CalcHammer
//
//  Created by Brett Hutt-Semple on 2024-01-21.
//

import SwiftUI
import UIKit

struct ConverterView: View {
    // Add a state variable to store the selected unit
    @State private var selectedUnitIndex = 0
    @State private var selectedUnitIndex2 = 0
    @State private var selectedUnitIndex3 = 0
    
    @State private var inputValue:Double = 0
    @State var output:Double = 0
    
    @Environment(\.modelContext) private var context
    
    func buttonPressConvert(unitType: Int,inputUnit:Int,outputUnit:Int,inputNum:Double) -> Double{
        //Function for deciding which conversion function to call
        var convertedOutput:Double = 0
        
        if unitType == 1 //length
        {
            convertedOutput = lengthConverter(inputUnit: inputUnit, outputUnit: outputUnit, inputNum: inputNum)
            addHistoryItem(inputUnitW: GlobalData.lengthUnit[inputUnit], outputUnitW: GlobalData.lengthUnit[outputUnit], inputNum: inputNum, outputNum: convertedOutput)
        }
        else if unitType == 2 //mass
        {
            convertedOutput = massConverter(inputUnit: inputUnit, outputUnit: outputUnit, inputNum: inputNum)
            addHistoryItem(inputUnitW: GlobalData.massUnit[inputUnit], outputUnitW: GlobalData.massUnit[outputUnit], inputNum: inputNum, outputNum: convertedOutput)

        }
        else if unitType == 3 //speed
        {
            convertedOutput = speedConverter(inputUnit: inputUnit, outputUnit: outputUnit, inputNum: inputNum)
            addHistoryItem(inputUnitW: GlobalData.speedUnit[inputUnit], outputUnitW: GlobalData.speedUnit[outputUnit], inputNum: inputNum, outputNum: convertedOutput)

        }
        else if unitType == 4 //temp
        {
            convertedOutput = tempConverter(inputUnit: inputUnit, outputUnit: outputUnit, inputNum: inputNum)
            addHistoryItem(inputUnitW: GlobalData.tempUnit[inputUnit], outputUnitW: GlobalData.tempUnit[outputUnit], inputNum: inputNum, outputNum: convertedOutput)

        }
        else if unitType == 5 //time
        {
            convertedOutput = timeConverter(inputUnit: inputUnit, outputUnit: outputUnit, inputNum: inputNum)
            addHistoryItem(inputUnitW: GlobalData.timeUnit[inputUnit], outputUnitW: GlobalData.timeUnit[outputUnit], inputNum: inputNum, outputNum: convertedOutput)

        }
        else if unitType == 6 //volume
        {
            convertedOutput = volumeConverter(inputUnit: inputUnit, outputUnit: outputUnit, inputNum: inputNum)
            addHistoryItem(inputUnitW: GlobalData.volumeUnit[inputUnit], outputUnitW: GlobalData.volumeUnit[outputUnit], inputNum: inputNum, outputNum: convertedOutput)

        }
        else if unitType == 7 //force
        {
            convertedOutput = forceConverter(inputUnit: inputUnit, outputUnit: outputUnit, inputNum: inputNum)
            addHistoryItem(inputUnitW: GlobalData.forceUnit[inputUnit], outputUnitW: GlobalData.forceUnit[outputUnit], inputNum: inputNum, outputNum: convertedOutput)

        }
        else if unitType == 8 //density
        {
            //tbd
        }
        else if unitType == 9 //angles
        {
            //tbd
        }
        else if unitType == 10 //num systems
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
        else if inputUnit == 8{//mile to meters
            convertedLength = convertedLength * 1609.35
        }
        else if inputUnit == 9{//nautical mile to meters
            convertedLength = convertedLength * 1852
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
    
    func addHistoryItem(inputUnitW:String,outputUnitW:String,inputNum:Double,outputNum: Double) {
        let item = ConversionHistoryItem(inputUnit: inputUnitW, outputUnit: outputUnitW, inputNum: inputNum, outputNum: outputNum)
        
        context.insert(item)
    }
    
    var body: some View {
        VStack {
            // Picker that selects system of unit
            Picker("Select Unit Type", selection: $selectedUnitIndex) {
                ForEach(Array(GlobalData.unitSystems.enumerated()), id: \.offset) { index, unit in
                    Text(unit)
                }

            }
            .pickerStyle(DefaultPickerStyle())
            .padding()
            
            Spacer()
            
            HStack{
                //Visual stack for input box and unit selection for input
                Spacer()
                //textfield for first input
                TextField("Enter Number", value: $inputValue,formatter: NumberFormatter())
                    .padding(/*@START_MENU_TOKEN@*/[.top, .leading, .bottom]/*@END_MENU_TOKEN@*/)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                
                //Switch for deciding which unit array for input 1
                switch selectedUnitIndex{
                case 1:
                    Picker("Select Unit", selection: $selectedUnitIndex2){
                        ForEach(Array(GlobalData.lengthUnit.enumerated()), id: \.offset) { index, unit in
                            Text(unit)
                        }


                    }
                case 2:
                    Picker("Select Unit", selection: $selectedUnitIndex2){
                        ForEach(Array(GlobalData.massUnit.enumerated()), id: \.offset) { index, unit in
                            Text(unit)
                        }


                    }
                case 3:
                    Picker("Select Unit", selection: $selectedUnitIndex2){
                        ForEach(Array(GlobalData.speedUnit.enumerated()), id: \.offset) { index, unit in
                            Text(unit)
                        }


                    }
                case 4:
                    Picker("Select Unit", selection: $selectedUnitIndex2){
                        ForEach(Array(GlobalData.tempUnit.enumerated()), id: \.offset) { index, unit in
                            Text(unit)
                        }


                    }
                case 5:
                    Picker("Select Unit", selection: $selectedUnitIndex2){
                        ForEach(Array(GlobalData.timeUnit.enumerated()), id: \.offset) { index, unit in
                            Text(unit)
                        }


                    }
                case 6:
                    Picker("Select Unit", selection: $selectedUnitIndex2){
                        ForEach(Array(GlobalData.volumeUnit.enumerated()), id: \.offset) { index, unit in
                            Text(unit)
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
                    Text("Please Select a Unit Type")
                }
                
                Spacer()
            }
            HStack{
                //Visual stack for output box and unit selection for output
                Spacer()
                Text("Your output is \(output)")
                Spacer()
                
                //Switch for deciding which unit array for output
                switch selectedUnitIndex{
                case 1:
                    Picker("Select Unit", selection: $selectedUnitIndex3){
                        ForEach(Array(GlobalData.lengthUnit.enumerated()), id: \.offset) { index, unit in
                            Text(unit)
                        }

                    }
                case 2:
                    Picker("Select Unit", selection: $selectedUnitIndex3){
                        ForEach(Array(GlobalData.massUnit.enumerated()), id: \.offset) { index, unit in
                            Text(unit)
                        }

                    }
                case 3:
                    Picker("Select Unit", selection: $selectedUnitIndex3){
                        ForEach(Array(GlobalData.speedUnit.enumerated()), id: \.offset) { index, unit in
                            Text(unit)
                        }

                    }
                case 4:
                    Picker("Select Unit", selection: $selectedUnitIndex3){
                        ForEach(Array(GlobalData.tempUnit.enumerated()), id: \.offset) { index, unit in
                            Text(unit)
                        }

                    }
                case 5:
                    Picker("Select Unit", selection: $selectedUnitIndex3){
                        ForEach(Array(GlobalData.timeUnit.enumerated()), id: \.offset) { index, unit in
                            Text(unit)
                        }

                    }
                case 6:
                    Picker("Select Unit", selection: $selectedUnitIndex3){
                        ForEach(Array(GlobalData.volumeUnit.enumerated()), id: \.offset) { index, unit in
                            Text(unit)
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
                    Text("Please Select a Unit Type")
                }
                Spacer()
            }
            Button("Convert") {
                //Calculate value of conversion
                output = buttonPressConvert(unitType:selectedUnitIndex,inputUnit: selectedUnitIndex2,outputUnit: selectedUnitIndex3,inputNum: inputValue)
            }
            Spacer()
        }
        .padding()
                .background(
                    Color.white.opacity(0.0001) // colour makes it so tap gesture works, dont question it
                        .onTapGesture { //dismisses keyboard when user taps anywheres but text field
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                )
    }
}
