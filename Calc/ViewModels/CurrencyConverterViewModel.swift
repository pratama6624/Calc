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
    
    let currencies = ["USD", "IDR", "EUR", "JPY", "GBP"]
    
    // Dummy rates
    private let rates: [CurrencyRate] = [
        CurrencyRate(from: "USD", to: "IDR", rate: 15000),
        CurrencyRate(from: "IDR", to: "USD", rate: 1/15000),
        CurrencyRate(from: "USD", to: "EUR", rate: 0.9),
        CurrencyRate(from: "EUR", to: "USD", rate: 1.1),
        CurrencyRate(from: "USD", to: "JPY", rate: 150),
        CurrencyRate(from: "JPY", to: "USD", rate: 0.0067)
    ]
    
    func convert() {
        guard let value = Double(amount) else {
            result = "Invalid amount"
            return
        }
        
        if let rate = rates.first(where: { $0.from == fromCurrency && $0.to == toCurrency }) {
            let converted = value * rate.rate
            result = "\(String(format: "%.2f", converted)) \(toCurrency)"
        } else {
            result = "\(value) \(toCurrency) (no rate yet)"
        }
    }
}
