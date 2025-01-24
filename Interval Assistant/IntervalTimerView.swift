//
//  IntervalTimerView.swift
//  Interval Assistant
//
//  Created by Lane Kersten on 12/12/24.
//

import SwiftUI

struct IntervalTimerView: View {
    @EnvironmentObject var intervalTimer: IntervalTimer
    @State var progressAnimation: Animation = .linear(duration: 0.2)
    
    var body: some View {
        
        VStack {
            Text("Set \(intervalTimer.getCurrentLoop()) of \(intervalTimer.loopNumber)")
                .font(.title3)
                .bold()
                .padding(32)
            
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.15))
                    .frame(width: 300, height: 300)
                CircularProgressView(progress: intervalTimer.getProgress(),
                                     color: .blue,
                                     animation: progressAnimation)
                    .frame(width: 250, height: 250)
                Text(intervalTimer.calculateTimer())
                    .font(.largeTitle)
                    .bold()
            }
            .frame(width: 300, height: 300)
            
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
                .padding(16)
                
                Spacer()
                
                Button {
                    progressAnimation = .linear(duration: 0)
                    if (intervalTimer.isPlaying) {
                        intervalTimer.reset()
                    } else {
                        intervalTimer.resetFullSet()
                    }
                
                } label: {
                    Image(systemName: intervalTimer.isPlaying ? "backward.fill" : "arrow.trianglehead.counterclockwise.rotate.90")
                        .frame(width: 80, height: 80)
                        .foregroundStyle(.white)
                        .background(intervalTimer.isPlaying ? Color.orange : Color.red)
                        .clipShape(Circle())
                }
                .buttonStyle(.borderless)
                .controlSize(.extraLarge)
                .padding(16)
            }
            .onReceive(intervalTimer.timer, perform: { _ in
                if (!intervalTimer.isPlaying) {
                    intervalTimer.stopTimer()
                    return
                }
                if (progressAnimation != .linear(duration: 0.2)) {
                    progressAnimation = .linear(duration: 0.2)
                }
                if (intervalTimer.timerUpdate()) {
                    progressAnimation = .linear(duration: 0)
                }

            })
            .background(RoundedRectangle(cornerRadius: 64).fill(Color.gray.opacity(0.15)))
            .padding(32)
        }
        .padding()
    }
}

#Preview {
    IntervalTimerView()
        .environmentObject(IntervalTimer())
}
