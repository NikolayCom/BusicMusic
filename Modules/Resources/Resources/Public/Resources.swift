import Foundation

//MARK: Resources

public enum Resources {
    // MARK: - Generated

    public static var strings: S.Type { S.self }
    public static var images: A.AuthImages.Type { A.AuthImages.self }
    public static var homeImages: A.HomeImages.Type { A.HomeImages.self }
    public static var colors: A.Colors.Type { A.Colors.self }


    // MARK: - Fonts

    public static func font(type: FontType, size: CGFloat) -> UIFont {
        let fontType = F.Figtree.self
        switch type {
        case .medium:
            return fontType.medium.font(size: size)

        case .bold:
            return fontType.bold.font(size: size)

        case .italic:
            return fontType.italic.font(size: size)

        case .regular:
            return fontType.regular.font(size: size)

        case .extraBold:
            return fontType.extraBold.font(size: size)

        case .system:
            return .boldSystemFont(ofSize: size)
        }
    }
}
