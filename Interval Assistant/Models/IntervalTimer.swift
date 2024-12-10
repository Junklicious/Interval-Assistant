//
//  IntervalTimer.swift
//  Interval Assistant
//
//  Created by Lane Kersten on 12/10/24.
//

import Foundation

struct IntervalTimer {
    var isPlaying: Bool = false
    var testTime: TimeInterval = 10000
    var endDate: Date?
    var progress: Double = 0.8
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    mutating func playPause() {
        if (isPlaying) {
            self.timer.upstream.connect().cancel()
            return
        }
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    mutating func reset() {
        progress = 0
    }
    
    func calculateTimer() -> String {
        let interval = 130
        let minutes = String(format: "%02d", interval / 60)
        let seconds = String(format: "%02d", interval % 60)
        return "\(minutes):\(seconds)"
    }
    
    mutating func calculateEndDate() {
        endDate = Date().addingTimeInterval(testTime)
    }
    
}
