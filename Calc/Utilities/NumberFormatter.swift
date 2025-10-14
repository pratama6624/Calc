//
//  NumberFormatter.swift
//  Calc
//
//  Created by Pratama One on 11/10/25.
//

import Foundation

extension Numeric {
    var formattedWithSeparator: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return formatter.string(for: self) ?? "\(self)"

    }
}

extension String {
    var formattedAsNumber: String {
        guard let value = Double(self) else { return self }
        return value.formattedWithSeparator
    }
}
