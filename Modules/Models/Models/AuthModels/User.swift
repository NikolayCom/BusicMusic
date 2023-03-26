import Foundation

public struct User {
    public var firstName: String
    public var lastName: String
    public var email: String
    public var password: String

    public init(
        firstName: String = "",
        lastName: String = "",
        email: String = "",
        password: String = ""
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
    }
}

// MARK: User setup

extension User {
    public mutating func setValue(with type: AuthRequiredDataType, value: String) {
        switch type {
        case .firstName:
            self.firstName = value

        case .lastName:
            self.lastName = value

        case .email:
            self.email = value

        case .password:
            self.password = value
        }
    }
}
