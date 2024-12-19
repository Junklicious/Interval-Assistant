//
//  EditTimerView.swift
//  Interval Assistant
//
//  Created by Lane Kersten on 12/12/24.
//

import SwiftUI

struct EditTimerView: View {
    @EnvironmentObject var intervalTimer: IntervalTimer
    @Environment(\.dismiss) var dismiss
    @State var activeMinutes: Int = 0
    @State var activeSeconds: Int = 0
    @State var restMinutes: Int = 0
    @State var restSeconds: Int = 0
    @State var numberOfRepeats: Int = 1
    
    var body: some View {
        Form {
            Text("Active Timer")
            HStack {
                Spacer()
                TimePickerView(title: "Minutes",
                               range: 0...59,
                               binding: $activeMinutes)
                Text(":")
                TimePickerView(title: "Seconds",
                               range: 1...59,
                               binding: $activeSeconds)
                Spacer()
            }
            .frame(height: 120)
            Text("Rest Timer")
            HStack {
                Spacer()
                TimePickerView(title: "Minutes",
                               range: 0...59,
                               binding: $restMinutes)
                Text(":")
                TimePickerView(title: "Seconds",
                               range: 1...59,
                               binding: $restSeconds)
                Spacer()
            }
            .frame(height: 120)
            Text("Repeat")
            HStack {
                Spacer()
                Picker("Repeats", selection: $numberOfRepeats) {
                    ForEach(1...100, id: \.self) { number in
                        Text("x\(number)")
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 100, height: 130)
                Spacer()
            }
            .frame(height: 120)
            Button {
                applyTimerSettings()
                dismiss()
            } label: {
                HStack {
                    Spacer()
                    Text("Done")
                    Spacer()
                }
            }
        }
    }
    
    func applyTimerSettings() {
        intervalTimer.intervalArray = [activeMinutes * 60 + activeSeconds,
                                       restMinutes * 60 + restSeconds]
        intervalTimer.loopNumber = numberOfRepeats
        intervalTimer.resetFullSet()
    }
}

#Preview {
    EditTimerView()
}
