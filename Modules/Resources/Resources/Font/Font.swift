import UIKit
import Rswift

// MARK: - FontType

public enum FontType: String {
    case medium = "Medium"
    case light = "Light"
    case bold = "Bold"
    case regular = "Regular"
}

// MARK: - Fonts used within the app

//extension R {
//    static let ptroot = "PTRootUI"
//
//    static func font(
//        of name: String = R.ptroot,
//        type: FontType = .regular,
//        size: CGFloat
//    ) -> UIFont {
//        getFont(baseFontName: name, type: type, size: size)
//    }
//}

// MARK: - Convenience methods

//extension R {
//    // swiftlint:disable force_unwrapping
//    static func getFont(
//        baseFontName: String,
//        type: FontType,
//        size: CGFloat
//    ) -> UIFont {
//        UIFont(name: "\(baseFontName)-\(type.rawValue)", size: size)!
//    }
//
//    // swiftlint:enable force_unwrapping
//}
