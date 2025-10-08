//
//  BMICalculatorView.swift
//  Calc
//
//  Created by Pratama One on 08/10/25.
//

import Foundation
import SwiftUI

struct BMICalculatorView: View {
    @StateObject private var viewModel = BMICalculatorViewModel()
    @EnvironmentObject var theme: ThemeViewModel
    
    var body: some View {
        VStack {
            
            // MARK: - Input Fields
            HStack(spacing: 16) {
                // Height Input
                VStack(alignment: .leading, spacing: 8) {
                    Text("Height (cm)")
                        .font(.caption)
                        .foregroundColor(.gray)
                    RoundedRectangle(cornerRadius: 16)
                        .fill(viewModel.activeField == .height
                              ? Color.blue.opacity(0.15)
                              : Color(.systemGray6))
                        .frame(height: 80)
                        .overlay(
                            Text(viewModel.height.isEmpty ? "0" : viewModel.height)
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                        )
                        .onTapGesture {
                            withAnimation { viewModel.activeField = .height }
                        }
                }

                // Weight Input
                VStack(alignment: .leading, spacing: 8) {
                    Text("Weight (kg)")
                        .font(.caption)
                        .foregroundColor(.gray)
                    RoundedRectangle(cornerRadius: 16)
                        .fill(viewModel.activeField == .weight
                              ? Color.orange.opacity(0.2)
                              : Color.orange.opacity(0.1))
                        .frame(height: 80)
                        .overlay(
                            Text(viewModel.weight.isEmpty ? "0" : viewModel.weight)
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                        )
                        .onTapGesture {
                            withAnimation { viewModel.activeField = .weight }
                        }
                }
            }
            .padding(.horizontal)
            .padding(.top, 30)
            
            Spacer()
            
            // MARK: - BMI Result
            if !viewModel.bmiResult.isEmpty {
                VStack(spacing: 8) {
                    Text(viewModel.bmiResult)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.orange)
                    Text(viewModel.bmiStatus)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(theme.isDarkMode ? .white : .black)
                }
                .transition(.opacity.combined(with: .scale))
                .padding(.bottom, 30)
            }
            
            // MARK: - Keypad
            VStack(spacing: 10) {
                ForEach(viewModel.buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { symbol in
                            Button(action: {
                                handleTap(symbol)
                            }) {
                                Text(symbol)
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .frame(width: 84, height: 84)
                                    .background(theme.isDarkMode ? Color.white.opacity(0.2) : Color.gray.opacity(0.1))
                                    .foregroundColor(theme.isDarkMode ? .white : .black)
                                    .cornerRadius(16)
                            }
                        }
                    }
                }
            }
            .padding(.bottom, 0)
            
            // MARK: - Bottom Buttons
            HStack(spacing: 12) {
                Button("C") {
                    withAnimation { viewModel.clearAll() }
                }
                .font(.title3)
                .frame(width: 84, height: 84)
                .background(Color.gray.opacity(0.1))
                .foregroundColor(!theme.isDarkMode ? .black : .white)
                .cornerRadius(16)
                
                Button("CALCULATE") {
                    withAnimation { viewModel.calculateBMI() }
                }
                .font(.title3)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, minHeight: 84)
                .foregroundColor(theme.isDarkMode ? .black : .white)
                .background(theme.isDarkMode ? Color.orange.opacity(0.8) : Color.orange)
                .cornerRadius(16)
            }
            .padding(.horizontal, 14)
        }
        .padding(.bottom, 20)
        .background(Color.gray.opacity(0.1).ignoresSafeArea())
    }
    
    // MARK: - Handle Keypad
    private func handleTap(_ symbol: String) {
        switch symbol {
        case "⌫": viewModel.deleteLast()
        default: viewModel.appendDigit(symbol)
        }
    }
}

#Preview {
    BMICalculatorView()
        .environmentObject(ThemeViewModel())
}
