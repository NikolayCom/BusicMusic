import Foundation
import Models
import Resources

public enum UIError: Error {
    // Auth
    case wrongUrl
    case empty
    case auth
    case developError
    case serverError
    case validation(message: String)
    case firebaseStorage(message: String?)

    public var message: String? {
        // to do: Добавить в локализацию
        let strings = Resources.strings
        switch self {
        case .auth:
            return "Auth error"

        case .developError:
            return "Develop Error"

        case .validation(let text):
            return text

        case .firebaseStorage(let text):
            return text.orEmpty

        case .empty:
            return "Empty"

        case .wrongUrl:
            return "WrongUrl"

        case .serverError:
            return "Server error"
        }
    }
}
