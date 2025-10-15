//
//  BMICalculatorViewModel.swift
//  Calc
//
//  Created by Pratama One on 08/10/25.
//

import Foundation
import SwiftUI

final class BMICalculatorViewModel: ObservableObject {
    @Published var height: String = ""
    @Published var weight: String = ""
    @Published var activeField: InputField = .height
    @Published var bmiResult: String = ""
    @Published var bmiStatus: String = ""
    
    enum InputField {
        case height, weight
    }
    
    let buttons: [[String]] = KeypadLayout().basicButtons
    
    func appendDigit(_ value: String) {
        switch activeField {
        case .height:
            if value == "." && height.contains(".") { return }
            height += value
        case .weight:
            if value == "." && weight.contains(".") { return }
            weight += value
        }
    }
    
    func deleteLast() {
        switch activeField {
        case .height:
            if !height.isEmpty { height.removeLast() }
        case .weight:
            if !weight.isEmpty { weight.removeLast() }
        }
    }
    
    func calculateBMI() {
        guard let h = Double(height), let w = Double(weight), h > 0 else {
            bmiResult = "Invalid"
            bmiStatus = ""
            return
        }
        let bmi = w / pow(h / 100, 2)
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        bmiResult = formatter.string(from: NSNumber(value: bmi)) ?? "\(bmi)"
        bmiStatus = category(for: bmi)
    }
    
    private func category(for bmi: Double) -> String {
        switch bmi {
        case ..<18.5: return "Underweight"
        case 18.5..<25: return "Normal"
        case 25..<30: return "Overweight"
        default: return "Obese"
        }
    }
    
    func clearAll() {
        height = ""
        weight = ""
        bmiResult = ""
        bmiStatus = ""
        activeField = .height
    }
}
