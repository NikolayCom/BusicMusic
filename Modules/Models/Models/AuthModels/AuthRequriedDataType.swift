import Foundation
import Resources

public enum AuthRequiredDataType {
    public typealias DataSection = [Self]

    case firstName
    case lastName
    case email
    case password

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
