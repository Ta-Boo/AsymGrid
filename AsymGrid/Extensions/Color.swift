import SwiftUI

extension Color {

    static func rgba(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1) -> Color {
        return Color(UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha))
    }

    struct Card {
        static let backgroundOutline = rgba(221, 221, 222, 1)
        static let foregroundOutline = rgba(51, 154, 254, 1)
    }
    
    static let Avatar = rgba(203, 51, 59, 1)

}
