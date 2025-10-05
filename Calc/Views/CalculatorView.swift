//
//  CalculatorView.swift
//  Calc
//
//  Created by Pratama One on 30/09/25.
//

import SwiftUI

struct CalculatorView: View {
    @StateObject private var viewModel = CalculatorViewModel()
    @EnvironmentObject var themeVM: ThemeViewModel
    
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
                        .foregroundStyle(!themeVM.isDarkMode ? .black : .white)
                        .lineLimit(1)
                        .padding(.trailing, 20)
                    
                    if !viewModel.result.isEmpty {
                        Text(viewModel.result)
                            .font(.system(size: 24))
                            .foregroundStyle(.pink)
                            .padding(.trailing, 20)
                    }
                }
            }
            .padding(.bottom, 20)
            
            // Buttons Grid
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            viewModel.receiveInput(button: button)
                        }) {
                            Text(button.rawValue)
                                .font(.system(size: 24, weight: .medium))
                                .foregroundStyle(!themeVM.isDarkMode ? button.foreSunColor : button.foreMoonColor)
                                .frame(width: 85, height: 85)
                                .fontWeight(.bold)
                                .background(button.backgroundColor)
                                .foregroundColor(.black)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
            }
            .padding(.bottom, 0)
        }
        .padding(.bottom, 20)
        .background(Color.gray.opacity(0.1).ignoresSafeArea())
    }
}

#Preview {
    CalculatorView()
        .environmentObject(ThemeViewModel())
}
