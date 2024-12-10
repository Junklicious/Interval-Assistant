//
//  Untitled.swift
//  Interval Assistant
//
//  Created by Lane Kersten on 10/1/24.
//

import SwiftUI

struct CircularProgressView: View {
    let width: CGFloat = 15
    let progress: Double
    let color: Color
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    color.opacity(0.5),
                    lineWidth: width
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    color,
                    style: StrokeStyle (
                        lineWidth: width,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
        }
    }
}

#Preview {
    CircularProgressView(progress: 0.8, color: .pink)
        .frame(width: 200, height: 200)
}