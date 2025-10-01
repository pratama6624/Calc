//
//  ModeSwitcherViewModel.swift
//  Calc
//
//  Created by Pratama One on 01/10/25.
//

import Foundation

class ModeSwitcherViewModel: ObservableObject {
    @Published var selectedMode: CalcMode = .calculator
}
