import Resources

public enum MainButtonStyle {
    case dark
    case light
    case attention

    var colors: (background: UIColor, textColor: UIColor) {
        let colors = Resources.colors
        switch self {
        case .dark:
            return (colors.c191414.color, colors.cffffff.color)

        case .light:
            return (colors.cffffff.color, colors.c191414.color)

        case .attention:
            return (colors.cffffff.color, colors.ce50914.color)
        }
    }
}

public enum MainButtonType {
    case `continue`
    case apple
    case clean

    enum Position {
        case right
        case center
    }

    var style: Position {
        switch self {
        case .continue:
            return .right

        case .apple, .clean:
            return .center
        }
    }

    var iconImage: UIImage? {
        let images = Resources.images

        switch self {
        case .continue:
            return UIImage(systemName: "arrow.forward")

        case .apple:
            return images.appleLogo.image

        case .clean:
            return nil
        }
    }
}
