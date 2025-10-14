//
//  ProfitMarginViewModel.swift
//  Calc
//
//  Created by Pratama One on 14/10/25.
//

import Foundation
import Combine

final class ProfitMarginViewModel: ObservableObject {
    @Published var costPrice: String = ""
    @Published var sellingPrice: String = ""
    @Published var profitMargin: String = ""
    @Published var profitAmount: String = ""
    @Published var isLoading: Bool = false
    
    // Keypad
    let buttons: [[String]] = [
        ["7", "8", "9", "0"],
        ["4", "5", "6", "."],
        ["1", "2", "3", "⌫"],
    ]
    
    @Published private(set) var activeField: ActiveField = .costPrice
    
    enum ActiveField {
        case costPrice, sellingPrice
    }
    
    func selectField(_ field: ActiveField) {
        activeField = field
    }
    
    func appendDigit(_ digit: String) {
        switch activeField {
        case .costPrice:
            costPrice += digit
        case .sellingPrice:
            sellingPrice += digit
        }
    }
    
    func deleteLast() {
        switch activeField {
        case .costPrice:
            if !costPrice.isEmpty { costPrice.removeLast() }
        case .sellingPrice:
            if !sellingPrice.isEmpty { sellingPrice.removeLast() }
        }
    }
    
    func clear() {
        costPrice = ""
        sellingPrice = ""
        profitMargin = ""
        profitAmount = ""
    }
    
    func calculateProfitMargin() {
        guard
            let cost = Double(costPrice),
            let sell = Double(sellingPrice),
            sell > 0
        else {
            profitMargin = "Invalid input"
            profitAmount = ""
            return
        }
        
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            let profit = sell - cost
            let margin = (profit / sell) * 100
            
            self.profitAmount = profit.formattedWithSeparator
            self.profitMargin = "\(Int(margin))%"
            self.isLoading = false
        }
    }
}
