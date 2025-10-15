//
//  CurrencyConverterViewModel.swift
//  Calc
//
//  Created by Pratama One on 03/10/25.
//

import Foundation
import SwiftUI

final class CurrencyConverterViewModel: ObservableObject {
    @Published var amount: String = "0"
    @Published var fromCurrency: String = "USD"
    @Published var toCurrency: String = "IDR"
    @Published var result: String = ""
    @Published var conversionInfo: String = ""
    @Published var rates: [String: Double] = [:]
    @Published var errorMessage: String?
    @Published var isLoading = false

    let currencies = ["USD", "EUR", "JPY", "IDR", "GBP", "SGD", "AUD", "CAD", "CHF", "CNY"]

    private let apiService = CurrencyAPIService()

    let buttons: [[String]] = KeypadLayout().basicButtons

    init() {}

    func appendDigit(_ digit: String) {
        if amount == "0" && digit != "." {
            amount = digit
        } else if digit == "." && amount.contains(".") {
            return
        } else {
            amount += digit
        }
    }

    func clear() {
        amount = "0"
        result = ""
        conversionInfo = ""
        errorMessage = nil
    }

    func deleteLast() {
        amount.removeLast()
        if amount.isEmpty { amount = "0" }
    }

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

    func fetchRates(completion: (() -> Void)? = nil) {
        DispatchQueue.main.async { self.isLoading = true }

        apiService.fetchRates { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self.rates = data
                    print("Rates loaded")
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("Error fetching rates:", error)
                }

                self.isLoading = false
                completion?()
            }
        }
    }

    func convert() {
        guard let inputValue = Double(amount) else { return }

        if rates.isEmpty {
            fetchRates {
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

        // Is not updated
        // Error
        // Cari tau agar ini dipanggil karena kasusnya UI tidak terupdate karena bagian ini tidak diupdate
        DispatchQueue.main.async {
            self.result = formattedResult
            self.conversionInfo = "1 \(self.fromCurrency) = \(formattedBase) \(self.toCurrency)"
            self.isLoading = false
            print("Conversion done: \(self.result)")
        }
    }
}
