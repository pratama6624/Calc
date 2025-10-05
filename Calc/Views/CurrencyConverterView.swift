//
//  CurrencyConverterView.swift
//  Calc
//
//  Created by Pratama One on 01/10/25.
//

import SwiftUI

struct CurrencyConverterView: View {
    @StateObject private var viewModel = CurrencyConverterViewModel()
    @EnvironmentObject var themeVM: ThemeViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Input Amount
            TextField("Enter amount", text: $viewModel.amount)
                .keyboardType(.decimalPad)
                .padding()
                .background(!themeVM.isDarkMode ? Color.gray.opacity(0.1) : Color(white: 0.15))
                .cornerRadius(10)
                .padding(.horizontal, 20)
            
            // From Currency Picker
            HStack {
                Text("From:")
                Spacer()
                Picker("From Currency", selection: $viewModel.fromCurrency) {
                    ForEach(viewModel.currencies, id: \.self) { currency in
                        Text(currency)
                    }
                }
                .accentColor(!themeVM.isDarkMode ? .black : .white)
                .pickerStyle(MenuPickerStyle())
            }
            .padding(.horizontal, 20)
            
            // To Currency Picker
            HStack {
                Text("To:")
                Spacer()
                Picker("To Currency", selection: $viewModel.toCurrency) {
                    ForEach(viewModel.currencies, id: \.self) { currency in
                        Text(currency)
                    }
                }
                .accentColor(!themeVM.isDarkMode ? .black : .white)
                .pickerStyle(MenuPickerStyle())
            }
            .padding(.horizontal, 20)
            
            // Result
            if !viewModel.result.isEmpty {
                VStack(spacing: 8) {
                    Text("\(viewModel.result)")
                        .font(.title3)
                        .fontWeight(.medium)
                    
                    if !viewModel.conversionInfo.isEmpty {
                        Text(viewModel.conversionInfo)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.top, 10)
            }
            
            Spacer()
            
            // Convert Button
            Button(action: {
                viewModel.convert()
            }) {
                Text("Convert")
                    .font(.headline)
                    .foregroundColor(!themeVM.isDarkMode ? .black : .white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(!themeVM.isDarkMode ? Color.gray.opacity(0.2) : Color(white: 0.2))
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    CurrencyConverterView()
        .environmentObject(ThemeViewModel())
}
