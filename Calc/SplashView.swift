//
//  SplashView.swift
//  Calc
//
//  Created by Pratama One on 15/10/25.
//

import SwiftUI

struct SplashView: View {
    @State private var isSpinning = false

    var body: some View {
        ZStack {
            Color(hex: "#FF9500")
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Circle()
                    .trim(from: 0, to: 0.7)
                    .stroke(Color.white.opacity(0.8), style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .frame(width: 40, height: 40)
                    .rotationEffect(.degrees(isSpinning ? 360 : 0))
                    .animation(.linear(duration: 1).repeatForever(autoreverses: false), value: isSpinning)

                Text("Loading...")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
        .onAppear {
            isSpinning = true
        }
    }
}

#Preview {
    SplashView()
}
