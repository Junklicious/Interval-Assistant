//
//  IntervalTimer.swift
//  Interval Assistant
//
//  Created by Lane Kersten on 12/10/24.
//

import SwiftUI
import AVFoundation

class IntervalTimer: ObservableObject {
    var intervalArray: [Int]
    var loopNumber: Int
    var currentIntervalIndex: Int = 0
    @Published var isPlaying: Bool = false
    @Published var timeRemaining: TimeInterval?
    @Published var endDate: Date?
    @Published var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    var audioPlayer: AVAudioPlayer?
    
    init() {
        let userDefaults = UserDefaults.standard
        intervalArray = userDefaults.array(forKey: UserDefaults.intervalArrayKey) as? [Int] ?? [30, 10]
        loopNumber = userDefaults.integer(forKey: UserDefaults.intervalLoopNumberKey)
        if (loopNumber == 0) {
            loopNumber = 2
        }
        timeRemaining = TimeInterval(getCurrentInverval())
    }
    
    func timerUpdate() -> Bool {
        if (timeRemaining == nil) {
            timeRemaining = TimeInterval(getCurrentInverval())
        }
        if (endDate == nil) {
            calculateEndDate()
        }
        
        timeRemaining = endDate!.distance(to: Date()) * -1
        
        if (timeRemaining! <= 0) {
            intervalOver()
            return true
        }
        return false
    }
    
    func intervalOver() {
        playAlert()
        if (currentIntervalIndex < getMaxIntervals() - 1) {
            currentIntervalIndex += 1
            reset()
        } else {
            stopTimer()
        }
    }
    
    func playPause() {
        if (isPlaying) {
            stopTimer()
            return
        }
        self.timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        isPlaying = true
    }
    
    func reset() {
        timeRemaining = TimeInterval(getCurrentInverval())
        endDate = nil
    }
    
    func resetFullSet() {
        currentIntervalIndex = 0
        reset()
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
        isPlaying = false
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
    
    func playAlert() {
        let fileName = currentIntervalIndex % 2 == 0 ? "Ping_down" : "Ping_up"
        let path = Bundle.main.path(forResource: fileName, ofType:"mp3")!
        let url = URL(fileURLWithPath: path)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            // Failed to load audio file
        }
    }
}
