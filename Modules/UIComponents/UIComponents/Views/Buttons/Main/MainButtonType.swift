public enum MainButtonType {
    case `continue`
    case clean

    var iconImageName: String? {
        switch self {
        case .continue:
            return "arrow.forward"

        case .clean:
            return nil
        }
    }
}
