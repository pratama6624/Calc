//
//  ContentView.swift
//  Calc
//
//  Created by Pratama One on 09/11/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ModeSwitcherViewModel()
    @EnvironmentObject var themeVM: ThemeViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation {
                        themeVM.isDarkMode.toggle()
                    }
                }) {
                    Image(systemName: themeVM.isDarkMode ? "moon.fill" : "sun.max.fill")
                        .font(.title2)
                        .foregroundColor(themeVM.isDarkMode ? .yellow : .orange)
                        .padding(.leading)
                }
                .padding(.trailing, 20)
                
                Spacer()
                
                Text(viewModel.selectedMode.rawValue)
                    .font(.title2)
                
                Spacer()
                
                Menu {
                    ForEach(CalcMode.allCases, id: \.self) { mode in
                        Button(action: {
                            viewModel.selectedMode = mode
                        }) {
                            Text(mode.rawValue)
                            if viewModel.selectedMode == mode {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .font(.title2)
                        .foregroundColor(!themeVM.isDarkMode ? .black : .white)
                        .padding()
                }
            }
            
            Spacer()
            
            // Show different UI based on selected mode
            switch viewModel.selectedMode {
            case .calculator:
                CalculatorView()
            case .unit:
                UnitConverterView()
            case .currency:
                CurrencyConverterView()
            case .binary:
                CalculatorView()
            case .bmi:
                BMICalculatorView()
            }
            
            Spacer()
        }
        .preferredColorScheme(themeVM.isDarkMode ? .dark : .light)
    }
}

#Preview {
    ContentView()
        .environmentObject(ThemeViewModel())
}
