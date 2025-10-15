//
//  CalcApp.swift
//  Calc
//
//  Created by Pratama One on 09/11/24.
//

import SwiftUI

@main
struct CalcApp: App {
    @State private var isLoading = true
    @StateObject private var themeVM = ThemeViewModel()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if isLoading {
                    SplashView()
                        .transition(.opacity.combined(with: .scale))
                        .onAppear {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isLoading = true
                            }

                            // Simulasi loading data 2 detik
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation(.easeInOut(duration: 0.6)) {
                                    isLoading = false
                                }
                            }
                        }
                } else {
                    ContentView()
                        .environmentObject(themeVM)
                }
            }
        }
    }
}
