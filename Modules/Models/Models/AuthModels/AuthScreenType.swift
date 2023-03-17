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

    public var emailButtonText: String {
        let emailStrings = Resources.strings.Auth.SignUp.Email
        switch self {
        case .login:
            return emailStrings.login

        case .registration:
            return emailStrings.join
        }
    }
}
