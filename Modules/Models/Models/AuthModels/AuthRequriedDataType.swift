import Foundation
import Resources

public enum AuthRequiredDataType: String {
    public typealias DataSection = [Self]

    case firstName
    case lastName
    case email
    case password

    public var keyboardConfig: (type: UIKeyboardType, isSecure: Bool) {
        switch self {
        case .firstName, .lastName:
            return (.default, false)

        case .email:
            return (.emailAddress, false)

        case .password:
            return (.default, true)
        }
    }

    public var placeholder: String {
        let emailStrings = Resources.strings.Auth.Email

        switch self {
        case .firstName:
            return emailStrings.firstName

        case .lastName:
            return emailStrings.lastName

        case .email:
            return emailStrings.email

        case .password:
            return emailStrings.password
        }
    }
}
