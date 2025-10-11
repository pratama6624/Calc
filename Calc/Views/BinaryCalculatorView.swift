//
//  BinaryCalculatorView.swift
//  Calc
//
//  Created by Pratama One on 08/10/25.
//

// BinaryCalculatorView.swift
import SwiftUI

struct BinaryCalculatorView: View {
    @StateObject private var viewModel = BinaryCalculatorViewModel()
    @EnvironmentObject var theme: ThemeViewModel

    var body: some View {
        VStack(spacing: 24) {
            // MARK: - Display (top-left big number)
            HStack {
                Spacer()
                Text(viewModel.displayText)
                    .font(.system(size: 48, weight: .bold, design: .rounded))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .padding(.horizontal)
            }

            // MARK: - Result Info (Decimal + Hex) placed near top-right
            if !viewModel.decimalResult.isEmpty {
                VStack(alignment: .trailing, spacing: 6) {
                    ResultRow(title: "Decimal", value: viewModel.decimalResult)
                    ResultRow(title: "Hexadecimal", value: viewModel.hexResult.uppercased())
                }
                .padding(.horizontal)
                .transition(.opacity.combined(with: .move(edge: .trailing)))
            }

            Spacer()

            // MARK: - Keypad (use viewModel.buttons)
            VStack(spacing: 10) {
                ForEach(viewModel.buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { symbol in
                            Button(action: {
                                viewModel.handleTap(symbol)
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

            // MARK: - Bottom Buttons (C and CALCULATE)
            HStack(spacing: 12) {
                Button(action: {
                    withAnimation { viewModel.clearAll() }
                }) {
                    Text("C")
                        .font(.title3)
                        .frame(width: 84, height: 84)
                        .background(Color.gray.opacity(0.1))
                        .foregroundColor(!theme.isDarkMode ? .black : .white)
                        .cornerRadius(16)
                }

                Button(action: {
                    withAnimation { viewModel.handleTap("=") }
                }) {
                    Text("CALCULATE")
                        .font(.title3)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, minHeight: 84)
                        .foregroundColor(theme.isDarkMode ? .black : .white)
                        .background(theme.isDarkMode ? Color.orange.opacity(0.8) : Color.orange)
                        .cornerRadius(16)
                }
            }
            .padding(.horizontal, 14)
        }
        .padding(.bottom, 20)
        .navigationTitle("Binary Calculator")
    }
}

private struct ResultRow: View {
    var title: String
    var value: String

    var body: some View {
        HStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.orange)
        }
    }
}

#Preview {
    BinaryCalculatorView()
        .environmentObject(ThemeViewModel())
}
