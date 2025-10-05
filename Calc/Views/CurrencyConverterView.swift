//
//  CurrencyConverterView.swift
//  Calc
//
//  Created by Pratama One on 01/10/25.
//

import Foundation
import SwiftUI

struct CurrencyConverterView: View {
    @StateObject private var viewModel = CurrencyConverterViewModel()
    @EnvironmentObject var themeVM: ThemeViewModel
    
    var body: some View {
        VStack(spacing: 25) {
            VStack(spacing: 8) {
                Text(viewModel.amount)
                    .font(.system(size: 50, weight: .semibold, design: .rounded))
                    .foregroundColor(themeVM.isDarkMode ? .white : .black)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, 14)
                    .padding(.top, 10)
                    .minimumScaleFactor(0.5)
                
                HStack {
                    Spacer()
                    if viewModel.isLoading {
                        Text("Fetching data...")
                                .foregroundColor(.orange)
                                .padding()
                    } else {
                        if !viewModel.result.isEmpty {
                            VStack(spacing: 6) {
                                Text(viewModel.result)
                                    .font(.title2)
                                    .foregroundColor(.orange)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.horizontal, 14)
                                Text(viewModel.conversionInfo)
                                    .font(.caption)
                                    .foregroundColor(.orange)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.horizontal, 14)
                            }
                            .padding(.top, 10)
                        }
                    }
                }
                .padding(.trailing, 14)
            }
            
            Spacer()
            
            HStack(spacing: 30) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("From")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.leading, 14)
                    Picker("", selection: $viewModel.fromCurrency) {
                        ForEach(viewModel.currencies, id: \.self) { currency in
                            Text(currency)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .accentColor(themeVM.isDarkMode ? .white : .black)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 5) {
                    Text("To")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.trailing, 14)
                    Picker("", selection: $viewModel.toCurrency) {
                        ForEach(viewModel.currencies, id: \.self) { currency in
                            Text(currency)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .accentColor(themeVM.isDarkMode ? .white : .black)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.horizontal, 4)
            .padding(.bottom, 20)
            
            VStack(spacing: 10) {
                ForEach(viewModel.buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { symbol in
                            Button(action: {
                                handleButtonTap(symbol)
                            }) {
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
                
                Button("CONVERT") {
                    viewModel.convert()
                }
                .font(.title3)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, minHeight: 84)
                .foregroundColor(themeVM.isDarkMode ? .black : .white)
                .background(themeVM.isDarkMode ? Color.orange.opacity(0.8) : Color.orange)
                .foregroundColor(.white)
                .cornerRadius(16)
            }
            .padding(.horizontal, 14)
        }
        .padding(.bottom, 20)
        .onChange(of: viewModel.result) { oldValue, newValue in
            print("result updated in UI: \(newValue)")
        }
        .onChange(of: viewModel.isLoading) { oldValue, newValue in
            print("isLoading changed: \(newValue)")
        }
        .animation(.easeInOut, value: viewModel.isLoading)
    }
    
    private func handleButtonTap(_ symbol: String) {
        switch symbol {
        case "⌫":
            viewModel.deleteLast()
        default:
            viewModel.appendDigit(symbol)
        }
    }
}

#Preview {
    CurrencyConverterView()
        .environmentObject(ThemeViewModel())
}
