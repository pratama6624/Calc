//
//  DistanceConverterViewModel.swift
//  Calc
//
//  Created by Pratama One on 03/10/25.
//

import Foundation

enum UnitConverterMode: String, CaseIterable {
    case distance, pressure, volume, weight, speed, time, temperature
}

class UnitConverterViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var input: String = ""
    @Published var fromUnit: String = ""
    @Published var toUnit: String = ""
    @Published var result: String = ""
    @Published var conversionInfo: String = ""
    @Published var selectedMode: UnitConverterMode = .distance
    
    // MARK: - Data
    @Published var units: [String] = []
    
    let buttons = [
        ["7", "8", "9", "0"],
        ["4", "5", "6", "."],
        ["1", "2", "3", "⌫"]
    ]
    
    // MARK: - Init
    init() {
        updateUnitsForMode()
    }
    
    // MARK: - Input Handling
    func appendDigit(_ value: String) {
        if value == "." && input.contains(".") { return }
        input += value
    }
    
    func deleteLast() {
        if !input.isEmpty {
            input.removeLast()
        }
    }
    
    func clear() {
        input = ""
        result = ""
        conversionInfo = ""
    }
    
    // MARK: - Mode & Units
    func updateUnitsForMode() {
        switch selectedMode {
        case .distance:
            units = ["Meter", "Kilometer", "Centimeter", "Mile"]
        case .pressure:
            units = ["Pascal", "Bar", "PSI"]
        case .volume:
            units = ["Liter", "Milliliter", "Gallon"]
        case .weight:
            units = ["Kilogram", "Gram", "Pound"]
        case .speed:
            units = ["m/s", "km/h", "mph"]
        case .time:
            units = ["Second", "Minute", "Hour"]
        case .temperature:
            units = ["Celsius", "Fahrenheit", "Kelvin"]
        }
        
        fromUnit = units.first ?? ""
        toUnit = units.last ?? ""
        clear()
    }
    
    // MARK: - Conversion Logic
    func convert() {
        guard let value = Double(input) else {
            result = "Invalid input"
            return
        }
        
        var convertedValue: Double = 0
        
        switch selectedMode {
        case .distance:
            convertedValue = convertDistance(value)
        case .pressure:
            convertedValue = convertPressure(value)
        case .volume:
            convertedValue = convertVolume(value)
        case .weight:
            convertedValue = convertWeight(value)
        case .speed:
            convertedValue = convertSpeed(value)
        case .time:
            convertedValue = convertTime(value)
        case .temperature:
            convertedValue = convertTemperature(value)
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        formatter.maximumFractionDigits = 4
        formatter.minimumFractionDigits = 0
        formatter.locale = Locale(identifier: "id_ID")

        let formattedConverted = formatter.string(from: NSNumber(value: convertedValue)) ?? "\(convertedValue)"
        let ratio = convertedValue / value
        let formattedRatio = formatter.string(from: NSNumber(value: ratio)) ?? "\(ratio)"
        
        result = "\(formattedConverted) \(toUnit)"
        conversionInfo = "1 \(fromUnit) = \(formattedRatio) \(toUnit)"
    }
    
    // MARK: - Distance Conversion (from your old code)
    private func convertDistance(_ value: Double) -> Double {
        var meters: Double = 0
        
        switch fromUnit {
        case "Meter": meters = value
        case "Kilometer": meters = value * 1000
        case "Centimeter": meters = value / 100
        case "Mile": meters = value * 1609.34
        default: meters = value
        }
        
        switch toUnit {
        case "Meter": return meters
        case "Kilometer": return meters / 1000
        case "Centimeter": return meters * 100
        case "Mile": return meters / 1609.34
        default: return meters
        }
    }
    
    // MARK: - Pressure Conversion
    private func convertPressure(_ value: Double) -> Double {
        var pascal: Double = 0
        
        switch fromUnit {
        case "Pascal": pascal = value
        case "Bar": pascal = value * 100000
        case "PSI": pascal = value * 6894.76
        default: pascal = value
        }
        
        switch toUnit {
        case "Pascal": return pascal
        case "Bar": return pascal / 100000
        case "PSI": return pascal / 6894.76
        default: return pascal
        }
    }
    
    // MARK: - Volume Conversion
    private func convertVolume(_ value: Double) -> Double {
        var liters: Double = 0
        
        switch fromUnit {
        case "Liter": liters = value
        case "Milliliter": liters = value / 1000
        case "Gallon": liters = value * 3.785
        default: liters = value
        }
        
        switch toUnit {
        case "Liter": return liters
        case "Milliliter": return liters * 1000
        case "Gallon": return liters / 3.785
        default: return liters
        }
    }
    
    // MARK: - Weight Conversion
    private func convertWeight(_ value: Double) -> Double {
        var kg: Double = 0
        
        switch fromUnit {
        case "Kilogram": kg = value
        case "Gram": kg = value / 1000
        case "Pound": kg = value * 0.453592
        default: kg = value
        }
        
        switch toUnit {
        case "Kilogram": return kg
        case "Gram": return kg * 1000
        case "Pound": return kg / 0.453592
        default: return kg
        }
    }
    
    // MARK: - Speed Conversion
    private func convertSpeed(_ value: Double) -> Double {
        var ms: Double = 0
        
        switch fromUnit {
        case "m/s": ms = value
        case "km/h": ms = value / 3.6
        case "mph": ms = value * 0.44704
        default: ms = value
        }
        
        switch toUnit {
        case "m/s": return ms
        case "km/h": return ms * 3.6
        case "mph": return ms / 0.44704
        default: return ms
        }
    }
    
    // MARK: - Time Conversion
    private func convertTime(_ value: Double) -> Double {
        var seconds: Double = 0
        
        switch fromUnit {
        case "Second": seconds = value
        case "Minute": seconds = value * 60
        case "Hour": seconds = value * 3600
        default: seconds = value
        }
        
        switch toUnit {
        case "Second": return seconds
        case "Minute": return seconds / 60
        case "Hour": return seconds / 3600
        default: return seconds
        }
    }
    
    // MARK: - Temperature Conversion
    private func convertTemperature(_ value: Double) -> Double {
        switch (fromUnit, toUnit) {
        case ("Celsius", "Fahrenheit"):
            return value * 9/5 + 32
        case ("Fahrenheit", "Celsius"):
            return (value - 32) * 5/9
        case ("Celsius", "Kelvin"):
            return value + 273.15
        case ("Kelvin", "Celsius"):
            return value - 273.15
        case ("Fahrenheit", "Kelvin"):
            return (value - 32) * 5/9 + 273.15
        case ("Kelvin", "Fahrenheit"):
            return (value - 273.15) * 9/5 + 32
        default:
            return value
        }
    }
}
