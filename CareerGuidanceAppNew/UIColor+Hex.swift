
import UIKit

extension UIColor {
    
    // Helper initializer to create UIColor from a Hex string (e.g., "1FA5A1")
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0

        let length = hexSanitized.count
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            let a = CGFloat(rgb & 0x000000FF) / 255.0
            self.init(red: r, green: g, blue: b, alpha: a)
            return
        }

        self.init(red: r, green: g, blue: b, alpha: alpha)
    }

    // ⭐️ Static property for the main background color (#F2F2F7)
    static let appBackground = UIColor(hex: "F2F2F7")
    
    // Static property for the main teal color (1FA5A1)
    static let appTeal = UIColor(hex: "1FA5A1")
    
    // Static property for the light background circle color
    static let appTealLightBackground = UIColor(red: 0.88, green: 0.95, blue: 0.95, alpha: 1.0)
    
    // MARK: - RIASEC Progress Bar Colors
    
    // Realistic (R) - 43B6E4 (Blue)
    static let riasecRealistic = UIColor(hex: "43B6E4")
    
    // Investigative (I) - E2E75E (Yellow/Lime)
    static let riasecInvestigative = UIColor(hex: "E2E75E")
    
    // Artistic (A) - 38CC62 (Green)
    static let riasecArtistic = UIColor(hex: "38CC62")
    
    // Social (S) - DD5DF4 (Purple/Pink)
    static let riasecSocial = UIColor(hex: "DD5DF4")
    
    // Enterprising (E) - F45D5D (Red)
    static let riasecEnterprising = UIColor(hex: "F45D5D")
    
    // Conventional (C) - 0C4FAB (Dark Blue/Indigo)
    static let riasecConventional = UIColor(hex: "0C4FAB")
}
