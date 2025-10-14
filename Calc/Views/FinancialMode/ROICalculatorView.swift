//
//  ROICalculatorView.swift
//  Calc
//
//  Created by Pratama One on 14/10/25.
//

import SwiftUI

struct ROICalculatorView: View {
    @StateObject private var viewModel = ROICalculatorViewModel()
    @EnvironmentObject var themeVM: ThemeViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 25) {
                
                VStack(spacing: 8) {
                    VStack(alignment: .trailing, spacing: 6) {
                        Text("Initial: \(viewModel.initialInvestment)")
                        Text("Final: \(viewModel.finalValue)")
                        Text("Time: \(viewModel.timePeriod) yr")
                    }
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(themeVM.isDarkMode ? .white : .black)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, 14)
                    .padding(.top, 10)
                    
                    ZStack {
                        Color.clear
                        if viewModel.isLoading {
                            Text("Calculating...")
                                .foregroundColor(.orange)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        } else if !viewModel.roiResult.isEmpty {
                            VStack(spacing: 6) {
                                Text("ROI: \(viewModel.roiResult)")
                                    .font(.title3)
                                    .foregroundColor(.orange)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.horizontal, 14)
                                
                                if !viewModel.annualizedROI.isEmpty {
                                    Text("Annualized: \(viewModel.annualizedROI)")
                                        .font(.caption)
                                        .foregroundColor(.orange)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .padding(.horizontal, 14)
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        }
                    }
                    .frame(height: 80)
                    .clipped()
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 14)
                }
                
                HStack(spacing: 14) {
                    fieldButton("Initial", active: .initialInvestment)
                    fieldButton("Final", active: .finalValue)
                    fieldButton("Time", active: .timePeriod)
                }
                .padding(.horizontal, 14)
                
                VStack(spacing: 10) {
                    ForEach(viewModel.buttons, id: \.self) { row in
                        HStack(spacing: 12) {
                            ForEach(row, id: \.self) { symbol in
                                Button(action: { handleButtonTap(symbol) }) {
                                    Text(symbol)
                                        .font(.title2)
                                        .frame(width: 84, height: 84)
                                        .background(themeVM.isDarkMode ? Color(white: 0.2) : Color.gray.opacity(0.1))
                                        .foregroundColor(themeVM.isDarkMode ? .white : .black)
                                        .cornerRadius(16)
                                }
                            }
                        }
                    }
                }
                .padding(.bottom, -10)
                
                HStack(spacing: 12) {
                    Button("C") {
                        viewModel.clear()
                    }
                    .font(.title3)
                    .frame(width: 84, height: 84)
                    .background(Color.gray.opacity(0.1))
                    .foregroundColor(!themeVM.isDarkMode ? .black : .white)
                    .cornerRadius(16)
                    
                    Button("CALCULATE") {
                        viewModel.calculateROI()
                    }
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, minHeight: 84)
                    .foregroundColor(themeVM.isDarkMode ? .black : .white)
                    .background(themeVM.isDarkMode ? Color.orange.opacity(0.8) : Color.orange)
                    .cornerRadius(16)
                }
                .padding(.horizontal, 14)
            }
            .padding(.bottom, 15)
            .animation(.easeInOut, value: viewModel.isLoading)
        }
        .frame(height: 638)
    }
    
    private var currentFieldLabel: String {
        switch viewModel.activeField {
        case .initialInvestment: return "Initial Investment"
        case .finalValue: return "Final Value"
        case .timePeriod: return "Time Period"
        }
    }
    
    private func handleButtonTap(_ symbol: String) {
        if symbol == "⌫" {
            viewModel.deleteLast()
        } else {
            viewModel.appendDigit(symbol)
        }
    }
    
    private func fieldButton(_ title: String, active: ROICalculatorViewModel.ActiveField) -> some View {
        Button(action: { viewModel.selectField(active) }) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(Color.orange.opacity(0.15))
                .foregroundColor(themeVM.isDarkMode ? .white : .black)
                .cornerRadius(12)
        }
    }
}

#Preview {
    ROICalculatorView()
        .environmentObject(ThemeViewModel())
}
