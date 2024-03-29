import Resources
import Constants

// MARK: AuthType

public enum AuthType: String, CaseIterable {
    case apple
    case facebook
    case google
    case email

    public var data: (title: String, image: UIImage?) {
        let authStrings = Resources.strings.Auth.SignInUP
        let images = Resources.images
        let colors = Resources.colors

        switch self {
        case .apple:
            return (authStrings.appleTitle, images.appleLogo.image)

        case .facebook:
            return (authStrings.facebookTitle, images.facebookLogo.image)

        case .google:
            return (authStrings.googleTitle, images.googleLogo.image)

        case .email:
            return (
                authStrings.emailTitle,
                UIImage(systemName: "envelope")?.withTintColor(.black)
            )
        }
    }
}
