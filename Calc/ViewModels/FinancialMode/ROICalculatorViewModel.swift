//
//  ROICalculatorViewModel.swift
//  Calc
//
//  Created by Pratama One on 14/10/25.
//

import Foundation
import Combine

final class ROICalculatorViewModel: ObservableObject {
    @Published var initialInvestment: String = ""
    @Published var finalValue: String = ""
    @Published var timePeriod: String = ""
    @Published var roiResult: String = ""
    @Published var annualizedROI: String = ""
    @Published var isLoading: Bool = false
    
    // Keypad layout
    let buttons: [[String]] = [
        ["7", "8", "9", "0"],
        ["4", "5", "6", "."],
        ["1", "2", "3", "⌫"]
    ]
    
    @Published private(set) var activeField: ActiveField = .initialInvestment
    
    enum ActiveField {
        case initialInvestment, finalValue, timePeriod
    }
    
    func selectField(_ field: ActiveField) {
        activeField = field
    }
    
    func appendDigit(_ digit: String) {
        switch activeField {
        case .initialInvestment:
            initialInvestment += digit
        case .finalValue:
            finalValue += digit
        case .timePeriod:
            timePeriod += digit
        }
    }
    
    func deleteLast() {
        switch activeField {
        case .initialInvestment:
            if !initialInvestment.isEmpty { initialInvestment.removeLast() }
        case .finalValue:
            if !finalValue.isEmpty { finalValue.removeLast() }
        case .timePeriod:
            if !timePeriod.isEmpty { timePeriod.removeLast() }
        }
    }
    
    func clear() {
        initialInvestment = ""
        finalValue = ""
        timePeriod = ""
        roiResult = ""
        annualizedROI = ""
    }
    
    func calculateROI() {
        guard
            let initial = Double(initialInvestment),
            let final = Double(finalValue),
            let time = Double(timePeriod),
            initial > 0,
            time > 0
        else {
            roiResult = "Invalid input"
            annualizedROI = ""
            return
        }
        
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            let roi = ((final - initial) / initial) * 100
            let annualized = (pow(final / initial, 1 / time) - 1) * 100
            
            self.roiResult = "\(roi.formattedWithSeparator)%"
            self.annualizedROI = "\(annualized.formattedWithSeparator)% /yr"
            self.isLoading = false
        }
    }
}
