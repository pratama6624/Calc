//
//  DistanceConverterViewModel.swift
//  Calc
//
//  Created by Pratama One on 03/10/25.
//

import Foundation

class DistanceConverterViewModel: ObservableObject {
    @Published var inputValue: String = ""
    @Published var fromUnit: String = "Meter"
    @Published var toUnit: String = "Kilometer"
    @Published var result: String = ""
    
    let units = ["Meter", "Kilometer", "Centimeter", "Mile"]

    func convert() {
        guard let value = Double(inputValue) else {
            result = "Invalid input"
            return
        }
        
        var meters: Double = 0
        
        switch fromUnit {
        case "Meter": meters = value
        case "Kilometer": meters = value * 1000
        case "Centimeter": meters = value / 100
        case "Mile": meters = value * 1609.34
        default: meters = value
        }
        
        var convertedValue: Double = 0
        switch toUnit {
        case "Meter": convertedValue = meters
        case "Kilometer": convertedValue = meters / 1000
        case "Centimeter": convertedValue = meters * 100
        case "Mile": convertedValue = meters / 1609.34
        default: convertedValue = meters
        }
        
        result = "\(Int(convertedValue)) \(toUnit)"
    }
}
