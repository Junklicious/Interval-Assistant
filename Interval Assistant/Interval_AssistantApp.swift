//
//  Interval_AssistantApp.swift
//  Interval Assistant
//
//  Created by Lane Kersten on 9/24/24.
//

import SwiftUI

@main
struct Interval_AssistantApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(IntervalTimer())
        }
    }
}
