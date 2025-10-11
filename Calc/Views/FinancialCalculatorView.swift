//
//  FinancialCalculatorView.swift
//  Calc
//
//  Created by Pratama One on 10/10/25.
//

import SwiftUI

struct FinancialCalculatorView: View {
    @State private var selectedMode: String = "Currency"
    @EnvironmentObject var themeVM: ThemeViewModel
    
    private var modes: [String] {
        ["Currency"] + FinancialMode.allCases.map { $0.rawValue }
    }
    
    var body: some View {
        VStack {
            // MARK: - Top Horizontal Switcher
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(modes, id: \.self) { mode in
                        Button(action: {
                            withAnimation(.easeInOut) {
                                selectedMode = mode
                            }
                        }) {
                            Text(mode)
                                .font(.subheadline)
                                .fontWeight(selectedMode == mode ? .bold : .regular)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(selectedMode == mode ? Color.orange : Color.gray.opacity(0.2))
                                .foregroundColor(selectedMode == mode ? .white : (themeVM.isDarkMode ? .white : .black))
                                .cornerRadius(12)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }
            
            Divider()
                .padding(.horizontal)
                .padding(.bottom, 8)
            
            // MARK: - Main Content Area
            Group {
                switch selectedMode {
                case "Currency":
                    CurrencyConverterView()
                case "Loan":
                    LoanCalculatorView()
                case "Interest":
                    InterestCalculatorView()
                case "Investment":
                    InvestmentCalculatorView()
                case "Tax":
                    TaxCalculatorView()
                default:
                    CurrencyConverterView()
                }
            }
            .transition(.opacity.combined(with: .move(edge: .trailing)))
        }
        .animation(.easeInOut, value: selectedMode)
    }
}

#Preview {
    FinancialCalculatorView()
        .environmentObject(ThemeViewModel())
}
