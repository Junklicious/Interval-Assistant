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
        
        VStack {
            ZStack {
                CircularProgressView(progress: intervalTimer.getProgress(), color: .blue)
                Text(intervalTimer.calculateTimer())
                    .font(.largeTitle)
                    .bold()
            }
            .frame(width: 250, height: 250)
            
            HStack {
                Button {
                    intervalTimer.playPause()
                } label: {
                    Image(systemName: intervalTimer.isPlaying ?
                          "pause.fill" : "play.fill")
                        .imageScale(.large)
                        .frame(width: 80, height: 80)
                        .foregroundStyle(.white)
                        .background(intervalTimer.isPlaying ?
                                    Color.blue : Color.green)
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
            .onReceive(intervalTimer.timer, perform: { _ in
                intervalTimer.timerUpdate()
            })
            .padding(32)
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environmentObject(IntervalTimer())
}
