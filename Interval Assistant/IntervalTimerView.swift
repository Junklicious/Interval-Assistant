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
                .font(.headline)
                .bold()
                .padding(32)
            ZStack {
                CircularProgressView(progress: intervalTimer.getProgress(), color: .blue, animation: progressAnimation)
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
                    progressAnimation = .linear(duration: 0)
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
                if (progressAnimation != .linear(duration: 0.2)) {
                    progressAnimation = .linear(duration: 0.2)
                }
                intervalTimer.timerUpdate()
            })
            .padding(32)
        }
        .padding()
    }
}

#Preview {
    IntervalTimerView()
        .environmentObject(IntervalTimer())
}
