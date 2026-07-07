import SwiftUI

enum Theme {
    static let accent = Color(hex: "#FF9F1C")
    static let background = Color(hex: "#151312")
    static let ink = Color(hex: "#FBF2E9")
    static let muted = Color(hex: "#C9A87E")

    static func font(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .monospaced)
    }

    static let cardCorner: CGFloat = 16
}

extension Color {
    init(hex: String) {
        let s = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var v: UInt64 = 0
        Scanner(string: s).scanHexInt64(&v)
        let r = Double((v >> 16) & 0xFF) / 255.0
        let g = Double((v >> 8) & 0xFF) / 255.0
        let b = Double(v & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
