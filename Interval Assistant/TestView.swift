//
//  TestView.swift
//  Interval Assistant
//
//  Created by Lane Kersten on 10/9/24.
//

import SwiftUI

struct TestView: View {
    @State var progress: Double = 0.8
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                CircularProgressView(progress: -progress + 1, color: .blue)
                    .frame(width: 170, height: 170)
                CircularProgressView(progress: progress, color: .pink)
                Text("\(progress * 100, specifier: "%.0f")")
                    .font(.largeTitle)
                    .bold()
            }.frame(width: 200, height: 200)
            Spacer()
            HStack {
                Slider(value: $progress, in: 0...1)
                Button("Reset") {
                    resetProgress()
                }.buttonStyle(.borderedProminent)
            }
            Spacer()
        }
        .padding()
    }
    
    func resetProgress() {
            progress = 0
        }
}

#Preview {
    TestView()
}
