//
//  CalculatorViewModel.swift
//  Calc
//
//  Created by Pratama One on 30/09/25.
//

import Foundation

class CalculatorViewModel: ObservableObject {
    @Published var display: String = "0"
    @Published var result: String = ""
    
    private var currentInput: String = ""
    
    func receiveInput(button: CalcButton) {
        switch button {
        case .parentheses:
            let openCount = currentInput.filter { $0 == "(" }.count
            let closeCount = currentInput.filter { $0 == ")" }.count
            
            if openCount == closeCount || currentInput.last == "(" || currentInput.isEmpty {
                currentInput += "("
            } else {
                currentInput += ")"
            }
            display = currentInput
            
        case .clear:
            currentInput = ""
            display = "0"
            result = ""
            
        case .delete:
            if !currentInput.isEmpty {
                currentInput.removeLast()
                display = currentInput.isEmpty ? "0" : currentInput
            }
            
        case .equal:
            calculateResult()
            
        default:
            currentInput += button.rawValue
            display = currentInput
        }
    }
    
    private func calculateResult() {
        let expression = currentInput
            .replacingOccurrences(of: "x", with: "*")
            .replacingOccurrences(of: "÷", with: "/")
            .replacingOccurrences(of: "+", with: "+")
            .replacingOccurrences(of: "-", with: "-")
        
        let exp: NSExpression = NSExpression(format: expression)
        if let value = exp.expressionValue(with: nil, context: nil) as? NSNumber {
            result = "= \(value)"
        } else {
            result = "Error"
        }
    }
}
