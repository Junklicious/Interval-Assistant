//
//  ContentView.swift
//  Interval Assistant
//
//  Created by Lane Kersten on 9/24/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var intervalTimer: IntervalTimer
    
    var body: some View {
        
        NavigationStack {
            VStack {
                IntervalTimerView()
            }
            .toolbar {
                NavigationLink {
                    EditTimerView()
                } label: {
                    Image(systemName: "timer")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(.blue)
                        .padding()
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(IntervalTimer())
}
