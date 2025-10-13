//
//  FinancialModeViewModel.swift
//  Calc
//
//  Created by Pratama One on 10/10/25.
//

import Foundation
import SwiftUI

// MARK: - Main Mode
enum FinancialCategory: String, CaseIterable {
    case currency = "Currency"
    case calculator = "Financial Calculator"
}

// MARK: - Financial Calculator Submodes
enum FinancialMode: String, CaseIterable {
    case loan = "Loan"
    case compoundInterest = "Compound Interest"
    case roi = "ROI"
    case profitMargin = "Profit Margin"
    case savings = "Savings Growth"
}

// MARK: - Main ViewModel
final class FinancialViewModel: ObservableObject {
    // MARK: - Published UI State
    @Published var selectedCategory: FinancialCategory = .currency
    @Published var selectedFinancialMode: FinancialMode = .loan
    
    // Currency States
    @Published var amount: String = "0"
    @Published var fromCurrency: String = "USD"
    @Published var toCurrency: String = "IDR"
    @Published var result: String = ""
    @Published var conversionInfo: String = ""
    @Published var rates: [String: Double] = [:]
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    // Financial States
    @Published var input1: String = ""
    @Published var input2: String = ""
    @Published var input3: String = ""
    @Published var financialResult: String = ""
    @Published var financialInfo: String = ""
    
    // MARK: - Data
    let currencies = ["USD", "EUR", "JPY", "IDR", "GBP", "SGD", "AUD", "CAD", "CHF", "CNY"]
    let buttons = [
        ["7", "8", "9", "0"],
        ["4", "5", "6", "."],
        ["1", "2", "3", "⌫"]
    ]
    private let apiService = CurrencyAPIService()
    
    // MARK: - Input Handling (Shared)
    func appendDigit(_ digit: String) {
        switch selectedCategory {
        case .currency:
            if amount == "0" && digit != "." {
                amount = digit
            } else if digit == "." && amount.contains(".") {
                return
            } else {
                amount += digit
            }
        case .calculator:
            if digit == "." && input1.contains(".") { return }
            input1 += digit
        }
    }
    
    func deleteLast() {
        switch selectedCategory {
        case .currency:
            amount.removeLast()
            if amount.isEmpty { amount = "0" }
        case .calculator:
            if !input1.isEmpty { input1.removeLast() }
        }
    }
    
    func clearAll() {
        switch selectedCategory {
        case .currency:
            amount = "0"
            result = ""
            conversionInfo = ""
            errorMessage = nil
        case .calculator:
            input1 = ""
            input2 = ""
            input3 = ""
            financialResult = ""
            financialInfo = ""
        }
    }
    
    // MARK: - CURRENCY CALCULATOR
    func fetchRatesIfNeeded(completion: (() -> Void)? = nil) {
        if !rates.isEmpty {
            completion?()
            return
        }

        DispatchQueue.main.async {
            self.isLoading = true
            self.errorMessage = nil
        }

        apiService.fetchRates { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let data):
                    self.rates = data
                    print("Rates loaded: \(data)")
                    completion?()
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("Error fetching rates:", error)
                }
            }
        }
    }
    
    func convertCurrency() {
        guard let inputValue = Double(amount) else { return }

        if rates.isEmpty {
            fetchRatesIfNeeded {
                self.performConversion(inputValue)
            }
        } else {
            performConversion(inputValue)
        }
    }

    private func performConversion(_ inputValue: Double) {
        guard let fromRate = rates[fromCurrency],
              let toRate = rates[toCurrency] else { return }

        let converted = inputValue / fromRate * toRate

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = toCurrency

        let formattedResult = formatter.string(from: NSNumber(value: converted)) ?? "\(converted)"
        let formattedBase = formatter.string(from: NSNumber(value: 1 / fromRate * toRate)) ?? ""

        DispatchQueue.main.async {
            self.result = formattedResult
            self.conversionInfo = "1 \(self.fromCurrency) = \(formattedBase) \(self.toCurrency)"
            self.isLoading = false
            print("Conversion done: \(self.result)")
        }
    }
    
    // MARK: - FINANCIAL CALCULATOR
    func calculateFinancial() {
        guard let val1 = Double(input1),
              let val2 = Double(input2) else {
            financialResult = "Invalid input"
            return
        }
        
        var output: Double = 0
        
        switch selectedFinancialMode {
        case .loan:
            guard let months = Double(input3) else { return }
            output = calculateLoan(principal: val1, rate: val2, months: months)
        case .compoundInterest:
            guard let years = Double(input3) else { return }
            output = calculateCompoundInterest(principal: val1, rate: val2, years: years)
        case .roi:
            guard let finalValue = Double(input3) else { return }
            output = calculateROI(initial: val1, final: finalValue)
        case .profitMargin:
            guard let cost = Double(input3) else { return }
            output = calculateProfitMargin(revenue: val1, cost: cost)
        case .savings:
            guard let years = Double(input3) else { return }
            output = calculateSavings(principal: val1, rate: val2, years: years)
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "id_ID")
        
        let formatted = formatter.string(from: NSNumber(value: output)) ?? "\(output)"
        financialResult = formatted
        financialInfo = descriptionForMode()
    }
    
    // MARK: - Financial Formulas
    private func calculateLoan(principal: Double, rate: Double, months: Double) -> Double {
        let monthlyRate = (rate / 100) / 12
        let numerator = monthlyRate * pow(1 + monthlyRate, months)
        let denominator = pow(1 + monthlyRate, months) - 1
        return principal * (numerator / denominator)
    }

    private func calculateCompoundInterest(principal: Double, rate: Double, years: Double) -> Double {
        return principal * pow(1 + rate / 100, years)
    }

    private func calculateSimpleInterest(principal: Double, rate: Double, years: Double) -> Double {
        return principal + (principal * rate / 100 * years)
    }

    private func calculateMortgage(principal: Double, rate: Double, years: Double) -> Double {
        let months = years * 12
        let monthlyRate = (rate / 100) / 12
        let numerator = monthlyRate * pow(1 + monthlyRate, months)
        let denominator = pow(1 + monthlyRate, months) - 1
        return principal * (numerator / denominator)
    }

    private func calculateROI(initial: Double, final: Double) -> Double {
        return ((final - initial) / initial) * 100
    }

    private func calculateProfitMargin(revenue: Double, cost: Double) -> Double {
        return ((revenue - cost) / revenue) * 100
    }

    private func calculateBreakEven(price: Double, variableCost: Double, fixedCost: Double) -> Double {
        return fixedCost / (price - variableCost)
    }

    private func calculateSavings(principal: Double, rate: Double, years: Double) -> Double {
        return principal * pow(1 + rate / 100, years)
    }

    private func descriptionForMode() -> String {
        switch selectedFinancialMode {
        case .loan: return "Monthly Payment"
        case .compoundInterest: return "Future Value"
        case .roi: return "Return on Investment (%)"
        case .profitMargin: return "Profit Margin (%)"
        case .savings: return "Total Savings After Period"
        }
    }
}
