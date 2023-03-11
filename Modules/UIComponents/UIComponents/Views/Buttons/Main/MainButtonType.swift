import Resources

public enum MainButtonType {
    case `continue`
    case apple
    case clean

    enum Style {
        case right
        case center
    }

    var style: Style {
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
