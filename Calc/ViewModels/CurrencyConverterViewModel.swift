//
//  CurrencyConverterViewModel.swift
//  Calc
//
//  Created by Pratama One on 03/10/25.
//

import Foundation
import SwiftUI

class CurrencyConverterViewModel: ObservableObject {
    @Published var amount: String = ""
    @Published var fromCurrency: String = "USD"
    @Published var toCurrency: String = "IDR"
    @Published var result: String = ""
    @Published var conversionInfo: String = ""
    
    let currencies = ["USD", "IDR", "EUR", "JPY", "GBP"]
    
    private let rates: [String: Double] = [
        "USD": 1.0,
        "IDR": 15000,
        "EUR": 0.9,
        "JPY": 150,
        "GBP": 0.78
    ]
    
    func convert() {
        guard let value = Double(amount) else {
            result = "Invalid input"
            conversionInfo = ""
            return
        }
        
        guard let fromRate = rates[fromCurrency], let toRate = rates[toCurrency] else {
            result = "Error"
            conversionInfo = ""
            return
        }
        
        let usdValue = value / fromRate
        let convertedValue = usdValue * toRate
        
        result = "\(Int(convertedValue)) \(toCurrency)"
        conversionInfo = conversionRateInfo(from: fromCurrency, to: toCurrency)
    }
        
    private func conversionRateInfo(from: String, to: String) -> String {
        guard let fromRate = rates[from], let toRate = rates[to] else { return "" }
        let rate = toRate / fromRate
        return "1 \(from) = \(rate) \(to)"
    }
}
