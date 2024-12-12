//
//  TimePickerView.swift
//  Interval Assistant
//
//  Created by Lane Kersten on 12/12/24.
//

import SwiftUI

struct TimePickerView: View {
    let title: String
    let range: ClosedRange<Int>
    let binding: Binding<Int>
    
    var body: some View {
        HStack {
            Picker(title, selection: binding) {
                ForEach(range, id: \.self) { number in
                    Text(String(format: "%02d", number))
                }
            }
            .pickerStyle(.wheel)
            .frame(width: 100, height: 130)
        }
    }
}

#Preview {
    @Previewable @State var test: Int = 0
    TimePickerView(title: "Minutes", range: 0...59, binding: $test)
}
