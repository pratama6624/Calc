//
//  DistanceConverterView.swift
//  Calc
//
//  Created by Pratama One on 01/10/25.
//

import SwiftUI

struct DistanceConverterView: View {
    @StateObject private var viewModel = DistanceConverterViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter value", text: $viewModel.inputValue)
                .keyboardType(.decimalPad)
                .padding()
                .background(Color.gray.opacity(0.1))
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
                .tint(.black)
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
                .tint(.black)
                .pickerStyle(MenuPickerStyle())
            }
            .padding(.horizontal, 20)
            
            if !viewModel.result.isEmpty {
                Text("\(viewModel.result)")
                    .font(.title3)
                    .bold()
                    .padding()
            }
            
            Spacer()
                        
            Button(action: {
                viewModel.convert()
            }) {
                Text("Convert")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(12)
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    DistanceConverterView()
}
