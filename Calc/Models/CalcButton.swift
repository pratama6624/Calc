//
//  CalcButton.swift
//  Calc
//
//  Created by Pratama One on 30/09/25.
//

import Foundation
import SwiftUI

enum CalcButton: String {
    case zero = "0", one = "1", two = "2", three = "3"
    case four = "4", five = "5", six = "6"
    case seven = "7", eight = "8", nine = "9"
    case add = "+", subtract = "-", multiply = "x", divide = "÷"
    case equal = "=", clear = "C", decimal = ".", percent = "%"
    case delete = "⌫", parentheses = "()"
    
    var backgroundColor: Color {
        switch self {
            case .add, .subtract, .multiply, .divide:
                return Color.gray.opacity(0.1)
            case .clear, .delete, .percent, .parentheses:
                return Color.gray.opacity(0.1)
            case .equal:
                return Color.orange.opacity(0.8)
            default:
                return Color.gray.opacity(0.1)
        }
    }
        
    var foreSunColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide:
            return Color.red
        case .clear, .delete, .percent, .parentheses:
            return Color.black
        case .equal:
            return Color.white
        default:
            return Color.black
        }
    }
    
    var foreMoonColor: Color {
        switch self {
        case .add, .subtract, .multiply, .divide:
            return Color.red
        case .clear, .delete, .percent, .parentheses:
            return Color.white
        case .equal:
            return Color.black
        default:
            return Color.white
        }
    }
}
