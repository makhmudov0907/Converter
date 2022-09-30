//
//  ContentView.swift
//  Converter
//
//  Created by Mirshod Makhmudov on 07/01/22.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = ""
    @State private var outputValue = ""
    @FocusState private var amountIsFocused: Bool
    
    @State private var inputUnitValue = 2
    let inputUnits = ["meters", "kilometers", "centimeters", "millimeters"]
    
    @State private var outputUnitValue = 2
    let outputUnits = ["meters", "kilometers", "centimeters", "millimeters"]
    
    var inputUnitAfterConversionToOutput: String {
        var output = ""
        var input = Measurement(value: 0, unit: UnitLength.meters)
        
        switch inputUnits[inputUnitValue] {
        case "meters":
            input = Measurement(value: Double(inputValue) ?? 0, unit: UnitLength.meters)
        case "kilometers":
            input = Measurement(value: Double(inputValue) ?? 0, unit: UnitLength.kilometers)
        case "centimeters":
            input = Measurement(value: Double(inputValue) ?? 0, unit: UnitLength.centimeters)
        case "millimeters":
            input = Measurement(value: Double(inputValue) ?? 0, unit: UnitLength.millimeters)
        default:
            input = Measurement(value: Double(inputValue) ?? 0, unit: UnitLength.meters)
        }
        
        switch outputUnits[outputUnitValue] {
        case "meters":
            output = String(describing: input.converted(to: UnitLength.meters))
        case "kilometers":
            output = String(describing: input.converted(to: UnitLength.kilometers))
        case "centimeters":
            output = String(describing: input.converted(to: UnitLength.centimeters))
        case "millimeters":
            output = String(describing: input.converted(to: UnitLength.millimeters))
        default:
            output = String(describing: input.converted(to: UnitLength.meters))
        }
        
        return output
        
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header:Text("Enter Input value here")) {
                    TextField("Input value", text: $inputValue)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                
                Section(header:Text("INPUT UNIT")) {
                    Picker("Input Unit ~", selection: $inputUnitValue){
                        ForEach(0..<inputUnits.count) {
                            Text("\(inputUnits[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header:Text("OUTPUT UNIT")) {
                    Picker("Output Unit ~", selection: $outputUnitValue){
                        ForEach(0..<outputUnits.count) {
                            Text("\(outputUnits[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header:Text("Check Output value here")) {
                    Text(inputUnitAfterConversionToOutput)
                }
            }
            .navigationTitle("Unit Conversions")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
