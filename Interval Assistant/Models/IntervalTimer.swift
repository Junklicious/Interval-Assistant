//
//  IntervalTimer.swift
//  Interval Assistant
//
//  Created by Lane Kersten on 12/10/24.
//

import SwiftUI
import AVFoundation

class IntervalTimer: ObservableObject {
    var intervalArray: [Int] = [20, 10]
    var loopNumber: Int = 2
    var currentIntervalIndex: Int = 0
    @Published var isPlaying: Bool = true
    @Published var timeRemaining: TimeInterval?
    @Published var endDate: Date?
    @Published var timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    func timerUpdate() {
        if (timeRemaining == nil) {
            timeRemaining = TimeInterval(getCurrentInverval())
        }
        if (endDate == nil) {
            calculateEndDate()
        }
        
        timeRemaining = endDate!.distance(to: Date()) * -1
        
        if (timeRemaining! <= 0) {
            intervalOver()
        }
    }
    
    func intervalOver() {
        //TODO: Implement proper sound on timer end
//        let systemSoundID: SystemSoundID = 1013
//        AudioServicesPlaySystemSound(systemSoundID)
        currentIntervalIndex += 1
        if (currentIntervalIndex < getMaxIntervals()) {
            reset()
        } else {
            timer.upstream.connect().cancel()
            isPlaying = false
        }
    }
    
    func playPause() {
        if (isPlaying) {
            self.timer.upstream.connect().cancel()
            isPlaying = false
            endDate = nil
            return
        }
        self.timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
        isPlaying = true
    }
    
    func reset() {
        timeRemaining = TimeInterval(getCurrentInverval())
        endDate = nil
    }
    
    func calculateTimer() -> String {
        guard let timeRemaining else { return "" }
        let minutes = String(format: "%02d", Int(timeRemaining) / 60)
        let seconds = String(format: "%02d", Int(timeRemaining) % 60)
        return "\(minutes):\(seconds)"
    }
    
    func calculateEndDate() {
        guard let timeRemaining else { return }
        endDate = Date().addingTimeInterval(timeRemaining)
    }
    
    func getCurrentInverval() -> Int {
        return intervalArray[currentIntervalIndex % intervalArray.count]
    }
    
    func getProgress() -> Double {
        guard let timeRemaining else { return 0 }
        return 1 - (Double(timeRemaining) / Double(getCurrentInverval()))
    }
    
    func getMaxIntervals() -> Int {
        return intervalArray.count * loopNumber
    }
    
    func getCurrentLoop() -> Int {
        return (currentIntervalIndex / intervalArray.count) + 1
    }
    
}
