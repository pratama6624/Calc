//
//  CurrencyConverterView.swift
//  Calc
//
//  Created by Pratama One on 01/10/25.
//

import SwiftUI

struct CurrencyConverterView: View {
    @StateObject private var viewModel = CurrencyConverterViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            
            // Input Amount
            TextField("Enter amount", text: $viewModel.amount)
                .keyboardType(.decimalPad)
                .padding()
                .background(Color.gray.opacity(0.1))
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
                .accentColor(.black)
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
                .accentColor(.black)
                .pickerStyle(MenuPickerStyle())
            }
            .padding(.horizontal, 20)
            
            // Result
            if !viewModel.result.isEmpty {
                Text("\(viewModel.result)")
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding(.top, 10)
            }
            
            Spacer()
            
            // Convert Button
            Button(action: {
                viewModel.convert()
            }) {
                Text("Convert")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    CurrencyConverterView()
}
