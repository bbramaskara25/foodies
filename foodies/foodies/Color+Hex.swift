//
//  Color+Hex.swift
//  foodies
//
//  Created by Eliza Vornia on 07/04/25.
//
import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: Double

        r = Double((int >> 16) & 0xFF) / 255
        g = Double((int >> 8) & 0xFF) / 255
        b = Double(int & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}
