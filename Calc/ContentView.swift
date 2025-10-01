//
//  ContentView.swift
//  Calc
//
//  Created by Pratama One on 09/11/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ModeSwitcherViewModel()
    
    var body: some View {
        VStack {
            // Top Switcher
            Picker("Mode", selection: $viewModel.selectedMode) {
                ForEach(CalcMode.allCases, id: \.self) { mode in
                    Text(mode.rawValue).tag(mode)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            Spacer()
            
            // Show different UI based on mode
            switch viewModel.selectedMode {
            case .calculator:
                CalculatorView()
            case .distance:
                DistanceConverterView()
            case .currency:
                CurrencyConverterView()
            }
        }
    }
}

#Preview {
    ContentView()
}
