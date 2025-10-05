//
//  DistanceConverterView.swift
//  Calc
//
//  Created by Pratama One on 01/10/25.
//

import SwiftUI

struct DistanceConverterView: View {
    @StateObject private var viewModel = DistanceConverterViewModel()
    @EnvironmentObject var themeVM: ThemeViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter value", text: $viewModel.inputValue)
                .keyboardType(.decimalPad)
                .padding()
                .background(!themeVM.isDarkMode ? Color.gray.opacity(0.1) : Color(white: 0.15))
                .cornerRadius(10)
                .padding(.horizontal, 20)
            
            HStack {
                Text("From:")
                Spacer()
                Picker("From Unit", selection: $viewModel.fromUnit) {
                    ForEach(viewModel.units, id: \.self) { unit in
                        Text(unit)
                            .foregroundColor(.black)
                    }
                }
                .accentColor(!themeVM.isDarkMode ? .black : .white)
                .pickerStyle(MenuPickerStyle())
            }
            .padding(.horizontal, 20)
                        
            HStack {
                Text("To:")
                Spacer()
                Picker("To Unit", selection: $viewModel.toUnit) {
                    ForEach(viewModel.units, id: \.self) { unit in
                        Text(unit)
                            .foregroundColor(.black)
                    }
                }
                .accentColor(!themeVM.isDarkMode ? .black : .white)
                .pickerStyle(MenuPickerStyle())
            }
            .padding(.horizontal, 20)
            
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
                        
            Button(action: {
                viewModel.convert()
            }) {
                Text("Convert")
                    .font(.headline)
                    .foregroundColor(!themeVM.isDarkMode ? .black : .white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(!themeVM.isDarkMode ? Color.gray.opacity(0.2) : Color(white: 0.2))
                    .cornerRadius(12)
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    DistanceConverterView()
        .environmentObject(ThemeViewModel())
}
