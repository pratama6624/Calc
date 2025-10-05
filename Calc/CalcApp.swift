//
//  CalcApp.swift
//  Calc
//
//  Created by Pratama One on 09/11/24.
//

import SwiftUI

@main
struct CalcApp: App {
//    @EnvironmentObject var themeVM: ThemeViewModel
    @StateObject private var themeVM = ThemeViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(themeVM)
        }
    }
}
