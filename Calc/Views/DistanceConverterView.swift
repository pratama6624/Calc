//
//  DistanceConverterView.swift
//  Calc
//
//  Created by Pratama One on 01/10/25.
//

import SwiftUI

struct DistanceConverterView: View {
    @StateObject private var viewModel = DistanceConverterViewModel()
    @EnvironmentObject var theme: ThemeViewModel  // biar nyatu sama dark/light mode lo
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 8) {
                Text(viewModel.input.isEmpty ? "0" : viewModel.input)
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(theme.isDarkMode ? .white : .black)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, 14)
                
                if !viewModel.result.isEmpty {
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
            }
            .padding(.vertical, 10)
            
            Spacer()
            
            HStack(spacing: 30) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("From")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.leading, 14)
                    Picker("", selection: $viewModel.fromUnit) {
                        ForEach(viewModel.units, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .accentColor(theme.isDarkMode ? .white : .black)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 5) {
                    Text("To")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.trailing, 14)
                    Picker("", selection: $viewModel.toUnit) {
                        ForEach(viewModel.units, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .accentColor(theme.isDarkMode ? .white : .black)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.horizontal, 4)
            .padding(.bottom, 25)
            
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
            
            HStack(spacing: 12) {
                Button("C") {
                    //
                }
                .font(.title3)
                .frame(width: 84, height: 84)
                .background(Color.gray.opacity(0.1))
                .foregroundColor(!theme.isDarkMode ? .black : .white)
                .cornerRadius(16)
                
                Button("CONVERT") {
                    viewModel.convert()
                }
                .font(.title3)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, minHeight: 84)
                .foregroundColor(theme.isDarkMode ? .black : .white)
                .background(theme.isDarkMode ? Color.orange.opacity(0.8) : Color.orange)
                .foregroundColor(.white)
                .cornerRadius(16)
            }
            .padding(.horizontal, 14)
        }
        .padding(.bottom, 20)
        .background(theme.isDarkMode ? Color.black : Color.white)
    }
    
    private func handleTap(_ symbol: String) {
        switch symbol {
        case "⌫": viewModel.deleteLast()
        default: viewModel.appendDigit(symbol)
        }
    }
}

#Preview {
    DistanceConverterView()
        .environmentObject(ThemeViewModel())
}
