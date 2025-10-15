//
//  LoanCalculatorViewModel.swift
//  Calc
//
//  Created by Pratama One on 11/10/25.
//

import Foundation
import Combine

final class LoanCalculatorViewModel: ObservableObject {
    @Published var principal: String = ""
    @Published var interestRate: String = ""
    @Published var duration: String = ""
    @Published var monthlyPayment: String = ""
    @Published var totalPayment: String = ""
    @Published var isLoading: Bool = false
    
    // Keypad
    let buttons: [[String]] = KeypadLayout().basicButtons
    
    @Published private(set) var activeField: ActiveField = .principal
    
    enum ActiveField {
        case principal, interest, duration
    }
    
    func selectField(_ field: ActiveField) {
        activeField = field
    }
    
    func appendDigit(_ digit: String) {
        switch activeField {
        case .principal:
            principal += digit
        case .interest:
            interestRate += digit
        case .duration:
            duration += digit
        }
    }
    
    func deleteLast() {
        switch activeField {
        case .principal:
            if !principal.isEmpty { principal.removeLast() }
        case .interest:
            if !interestRate.isEmpty { interestRate.removeLast() }
        case .duration:
            if !duration.isEmpty { duration.removeLast() }
        }
    }
    
    func clear() {
        principal = ""
        interestRate = ""
        duration = ""
        monthlyPayment = ""
        totalPayment = ""
    }
    
    func calculateLoan() {
        guard
            let p = Double(principal),
            let r = Double(interestRate),
            let n = Double(duration)
        else {
            monthlyPayment = "Invalid input"
            totalPayment = ""
            return
        }
        
        isLoading = true
        
        // Delay simulation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            let monthlyRate = r / 100 / 12
            let numerator = p * monthlyRate * pow(1 + monthlyRate, n)
            let denominator = pow(1 + monthlyRate, n) - 1
            let m = numerator / denominator
            let total = m * n
            
            self.monthlyPayment = m.formattedWithSeparator
            self.totalPayment = total.formattedWithSeparator
            self.isLoading = false
        }
    }
}

