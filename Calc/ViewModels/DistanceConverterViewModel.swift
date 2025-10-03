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
    @Published var conversionInfo: String = ""
    
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
        
        conversionInfo = conversionRateInfo(from: toUnit)
    }
    
    private func conversionRateInfo(from unit: String) -> String {
        switch unit {
        case "Meter": return "1 Meter = 100 Centimeter"
        case "Kilometer": return "1 Kilometer = 1000 Meter"
        case "Centimeter": return "1 Centimeter = 0.01 Meter"
        case "Mile": return "1 Mile ≈ 1609 Meter"
        default: return ""
        }
    }
}
