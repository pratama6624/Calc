//
//  CalculatorView.swift
//  Calc
//
//  Created by Pratama One on 30/09/25.
//

import SwiftUI

struct CalculatorView: View {
    @StateObject private var viewModel = CalculatorViewModel()
    
    let buttons: [[CalcButton]] = [
        [.clear, .delete, .parentheses, .add],
        [.seven, .eight, .nine, .subtract],
        [.four, .five, .six, .multiply],
        [.one, .two, .three, .divide],
        [.decimal, .zero, .percent, .equal]
    ]
    
    var body: some View {
        VStack {
            Spacer()
            
            // Display
            HStack {
                Spacer()
                VStack(alignment: .trailing, spacing: 3) {
                    Text(viewModel.display)
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(.black)
                        .lineLimit(1)
                        .padding(.trailing)
                    
                    if !viewModel.result.isEmpty {
                        Text(viewModel.result)
                            .font(.system(size: 24))
                            .foregroundStyle(.pink)
                            .padding(.trailing)
                    }
                }
            }
            
            // Buttons Grid
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 12) {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            viewModel.receiveInput(button: button)
                        }) {
                            Text(button.rawValue)
                                .font(.system(size: 24, weight: .medium))
                                .frame(width: 70, height: 70)
                                .background(button.backgroundColor)
                                .foregroundColor(.black)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
            }
            .padding(.bottom, 8)
        }
        .padding()
        .background(Color.purple.opacity(0.1).ignoresSafeArea())
    }
}

#Preview {
    CalculatorView()
}
