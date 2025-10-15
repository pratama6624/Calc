//
//  KeypadLayout.swift
//  YourAppName
//
//  Created by Pratama on 15/10/25.
//

import Foundation

struct KeypadLayout {
    let basicButtons: [[String]] = [
        ["7", "8", "9", "0"],
        ["4", "5", "6", "."],
        ["1", "2", "3", "⌫"]
    ]
    
    let binaryButtons: [[String]] = [
        ["1", "0", "()", "⌫"],
        ["+", "-", "x", "÷"],
    ]
}
