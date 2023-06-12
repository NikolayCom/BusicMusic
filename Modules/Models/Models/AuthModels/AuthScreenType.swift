import Resources

public enum AuthScreenType {
    case login
    case registration

    public var title: (title: String, subtitle: String) {
        let authStrings = Resources.strings.Auth
        switch self {
        case .registration:
            return (authStrings.SignUp.joinUs, authStrings.SignUp.signUp)

        case .login:
            return (authStrings.SignIn.welcome, authStrings.SignIn.logIn)
        }
    }
}

// MARK: - Auth/Reg with email screen

public extension AuthScreenType {
    var emailButtonText: String {
        let emailStrings = Resources.strings.Auth.Email
        switch self {
        case .login:
            return emailStrings.login

        case .registration:
            return emailStrings.join
        }
    }

    var emailTitleSubtitle: (title: String, subtitle: String)? {
        let emailStrings = Resources.strings.Auth.Email
        switch self {
        case .login:
            return nil

        case .registration:
            return (emailStrings.createAccount, emailStrings.information)
        }
    }

    var emailScreenDataTypes: [AuthRequiredDataType.DataSection] {
        switch self {
        case .login:
            return [
                [.email, .password]
            ]

        case .registration:
            return [
                [.firstName, .lastName],
                [.email, .password]
            ]
        }
    }
}
