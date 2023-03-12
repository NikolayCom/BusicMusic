import Foundation
import Models
import Resources

public enum UIError: Error {
    // Auth
    case auth

    case developError

    public var message: String? {
        // to do: Добавить в локализацию
        let strings = Resources.strings
        switch self {
        case .auth:
            return "Auth error"

        case .developError:
            return "Develop Error"
        }
    }
}

