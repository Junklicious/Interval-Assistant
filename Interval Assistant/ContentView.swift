//
//  ContentView.swift
//  Interval Assistant
//
//  Created by Lane Kersten on 9/24/24.
//

import SwiftUI

struct ContentView: View {
    @State var intervalTimer: IntervalTimer = IntervalTimer()
    var body: some View {
        
        VStack {
            ZStack {
                CircularProgressView(progress: intervalTimer.progress, color: .blue)
                Text(intervalTimer.calculateTimer())
                    .font(.largeTitle)
                    .bold()
            }
            .frame(width: 250, height: 250)
            
            HStack {
                Button {
                    intervalTimer.playPause()
                } label: {
                    Image(systemName: intervalTimer.isPlaying ? "pause.fill" : "play.fill")
                        .imageScale(.large)
                        .frame(width: 80, height: 80)
                        .foregroundStyle(.white)
                        .background(Color.green)
                        .clipShape(Circle())
                }
                .buttonStyle(.borderless)
                .controlSize(.extraLarge)
                
                Spacer()
                
                Button {
                    intervalTimer.reset()
                } label: {
                    Image(systemName: "arrow.trianglehead.counterclockwise.rotate.90")
                        .frame(width: 80, height: 80)
                        .foregroundStyle(.white)
                        .background(Color.orange)
                        .clipShape(Circle())
                }
                .buttonStyle(.borderless)
                .controlSize(.extraLarge)
            }
            .padding(32)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
