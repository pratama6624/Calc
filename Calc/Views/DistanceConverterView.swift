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
    
    let buttons = [
        ["7", "8", "9", "0"],
        ["4", "5", "6", "."],
        ["1", "2", "3", "⌫"]
    ]
    
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
                        .font(.title3)
                        .foregroundColor(.orange)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal, 14)
                }
            }
            .padding(.vertical, 10)
            
            Spacer()
            
            HStack {
                Picker("From", selection: $viewModel.fromUnit) {
                    ForEach(viewModel.units, id: \.self) { unit in
                        Text(unit)
                    }
                }
                .accentColor(theme.isDarkMode ? .white : .black)
                .pickerStyle(MenuPickerStyle())
                
                Spacer()
                Text("→")
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer()
                
                Picker("To", selection: $viewModel.toUnit) {
                    ForEach(viewModel.units, id: \.self) { unit in
                        Text(unit)
                    }
                }
                .accentColor(theme.isDarkMode ? .white : .black)
                .pickerStyle(MenuPickerStyle())
            }
            .padding(.horizontal, 4)
            
            VStack(spacing: 10) {
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { symbol in
                            Button(action: {
                                handleTap(symbol)
                            }) {
                                Text(symbol)
                                    .font(.title2)
                                    .fontWeight(.medium)
                                    .frame(width: 84, height: 84)
                                    .background(theme.isDarkMode ? Color.white.opacity(0.1) : Color.gray.opacity(0.2))
                                    .foregroundColor(theme.isDarkMode ? .white : .black)
                                    .cornerRadius(16)
                            }
                        }
                    }
                }
            }
            .padding(.bottom, 0)
            
            Button(action: { viewModel.convert() }) {
                Text("CONVERT")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(theme.isDarkMode ? .black : .white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .padding()
                    .background(theme.isDarkMode ? Color.orange.opacity(0.8) : Color.orange)
                    .cornerRadius(12)
                    .padding(.horizontal, 14)
            }
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
