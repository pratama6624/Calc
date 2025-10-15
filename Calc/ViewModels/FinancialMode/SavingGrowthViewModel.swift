//
//  SavingGrowthViewModel.swift
//  Calc
//
//  Created by Pratama One on 14/10/25.
//

import Foundation
import Combine

final class SavingGrowthViewModel: ObservableObject {
    @Published var initialSaving: String = ""
    @Published var interestRate: String = ""
    @Published var durationYears: String = ""
    @Published var totalAmount: String = ""
    @Published var totalInterest: String = ""
    @Published var isLoading: Bool = false
    
    // Keypad
    let buttons: [[String]] = KeypadLayout().basicButtons
    
    @Published private(set) var activeField: ActiveField = .initialSaving
    
    enum ActiveField {
        case initialSaving, interestRate, durationYears
    }
    
    func selectField(_ field: ActiveField) {
        activeField = field
    }
    
    func appendDigit(_ digit: String) {
        switch activeField {
        case .initialSaving:
            initialSaving += digit
        case .interestRate:
            interestRate += digit
        case .durationYears:
            durationYears += digit
        }
    }
    
    func deleteLast() {
        switch activeField {
        case .initialSaving:
            if !initialSaving.isEmpty { initialSaving.removeLast() }
        case .interestRate:
            if !interestRate.isEmpty { interestRate.removeLast() }
        case .durationYears:
            if !durationYears.isEmpty { durationYears.removeLast() }
        }
    }
    
    func clear() {
        initialSaving = ""
        interestRate = ""
        durationYears = ""
        totalAmount = ""
        totalInterest = ""
    }
    
    func calculateSavingGrowth() {
        guard
            let p = Double(initialSaving),
            let r = Double(interestRate),
            let t = Double(durationYears)
        else {
            totalAmount = "Invalid input"
            totalInterest = ""
            return
        }
        
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            let monthlyRate = r / 100 / 12
            let totalMonths = 12 * t
            let amount = p * pow(1 + monthlyRate, totalMonths)
            let interestEarned = amount - p
            
            self.totalAmount = amount.formattedWithSeparator
            self.totalInterest = interestEarned.formattedWithSeparator
            self.isLoading = false
        }
    }
}
