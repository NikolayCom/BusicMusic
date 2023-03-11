import Resources

// MARK: SignInUp + ScreenConfig

extension SignInUpViewModel {
    enum ScreenType {
        case login
        case registration

        var text: (title: String, subtitle: String) {
            switch self {
            case .registration:
                let signUp = Resources.strings.Auth.SignUp
                return (signUp.joinUs, signUp.signUp)

            case .login:
                let signIn = Resources.strings.Auth.SignIn
                return (signIn.welcome, signIn.logIn)
            }
        }
    }
}
