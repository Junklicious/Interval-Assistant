//
//  ColorTheme.swift
//  Interval Assistant
//
//  Created by Lane Kersten on 12/13/24.
//

import SwiftUI

struct ColorTheme {
    let accent = Color("accent")
    let background = Color("background")
    let primaryText = Color("primaryText")
    let secondaryText = Color("secondaryText")
    let primaryIcon = Color("primaryIcon")
}

extension Color {
    static let colorTheme = ColorTheme()
}
