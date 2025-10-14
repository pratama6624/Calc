//
//  CompoundInterestViewModel.swift
//  Calc
//
//  Created by Pratama One on 12/10/25.
//

import Foundation
import SwiftUI
import Combine

final class CompoundInterestViewModel: ObservableObject {
    @Published var principal: String = ""
    @Published var rate: String = ""
    @Published var time: String = ""
    @Published var frequency: String = ""
    @Published var compoundInterest: String = ""
    @Published var totalAmount: String = ""
    @Published var isLoading: Bool = false
    
    let buttons: [[String]] = [
        ["7", "8", "9", "0"],
        ["4", "5", "6", "."],
        ["1", "2", "3", "⌫"],
    ]
    
    @Published private(set) var activeField: ActiveField = .principal
    
    enum ActiveField {
        case principal, rate, time, frequency
    }
    
    func selectField(_ field: ActiveField) {
        activeField = field
    }
    
    func appendDigit(_ digit: String) {
        switch activeField {
        case .principal:
            principal += digit
        case .rate:
            rate += digit
        case .time:
            time += digit
        case .frequency:
            frequency += digit
        }
    }
    
    func deleteLast() {
        switch activeField {
        case .principal:
            if !principal.isEmpty { principal.removeLast() }
        case .rate:
            if !rate.isEmpty { rate.removeLast() }
        case .time:
            if !time.isEmpty { time.removeLast() }
        case .frequency:
            if !frequency.isEmpty { frequency.removeLast() }
        }
    }
    
    func clear() {
        principal = ""
        rate = ""
        time = ""
        frequency = "1"
        compoundInterest = ""
        totalAmount = ""
    }
    
    func calculateCompoundInterest() {
        guard
            let p = Double(principal),
            let r = Double(rate),
            let t = Double(time),
            let n = Double(frequency)
        else {
            compoundInterest = "Invalid input"
            totalAmount = ""
            return
        }
        
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            let amount = p * pow(1 + (r / (100 * n)), n * t)
            let ci = amount - p
            
            self.compoundInterest = ci.formattedWithSeparator
            self.totalAmount = amount.formattedWithSeparator
            self.isLoading = false
        }
    }
}

extension Double {
    var formattedWithSeparator: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
