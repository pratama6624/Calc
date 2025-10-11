//
//  BinaryCalculatorViewModel.swift
//  Calc
//
//  Created by Pratama One on 08/10/25.
//

// BinaryCalculatorViewModel.swift
import Foundation
import SwiftUI

class BinaryCalculatorViewModel: ObservableObject {
    @Published var displayText: String = "0"
    @Published var decimalResult: String = ""
    @Published var hexResult: String = ""
    
    private var currentInput: String = ""
    private var operation: String = ""
    private var firstValue: Int?
    
    let buttons: [[String]] = [
        ["1", "0", "()", "⌫"],
        ["+", "-", "x", "÷"],
    ]
    
    // MARK: - Append Digit
    func appendDigit(_ digit: String) {
        if currentInput.count >= 16 { return }
        currentInput.append(digit)
        displayText += digit
    }
    
    // MARK: - Delete Last
    func deleteLast() {
        guard !currentInput.isEmpty else { return }
        currentInput.removeLast()
        displayText = currentInput.isEmpty ? "0" : currentInput
    }
    
    // MARK: - Handle Button Tap
    func handleTap(_ symbol: String) {
        print("Tapped:", symbol)
        switch symbol {
        case "C":
            clearAll()
        case "⌫":
            deleteLast()
        case "+", "-", "x", "÷":
            setOperation(symbol)
        case "=":
            calculateResult()
        case "0", "1":
            appendDigit(symbol)
        default:
            print("ignored:", symbol)
        }
    }
    
    // MARK: - Set Operation
    private func setOperation(_ symbol: String) {
        guard let value = Int(currentInput, radix: 2) else { return }
        firstValue = value
        operation = symbol
        displayText += " " + symbol + " "
        print("Operation set:", symbol, "first:", value)
    }
    
    // MARK: - Calculate Result
    func calculateResult() {
        guard let first = firstValue,
              let second = Int(currentInput, radix: 2) else { return }

        var result = 0

        switch operation {
        case "+": result = first + second
        case "-": result = first - second
        case "x": result = first * second
        case "÷": result = second == 0 ? 0 : first / second
        default: return
        }
        
        print("first: \(first) + second: \(second) = \(result)")

        displayText += " = " + String(result, radix: 2)
        decimalResult = String(result)
        hexResult = String(result, radix: 16)
        
        // reset state biar siap operasi baru
        currentInput = String(result, radix: 2)
        firstValue = nil
        operation = ""
    }
    
    // MARK: - Clear All
    func clearAll() {
        displayText = "0"
        currentInput = ""
        operation = ""
        firstValue = nil
        decimalResult = ""
        hexResult = ""
    }
}
