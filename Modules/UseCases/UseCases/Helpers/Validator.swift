import Extensions

// MARK: - Validator

public protocol Validator {
    func isEmail(_ text: String) -> Bool
    func isPassword(_ text: String) -> Bool
    func isName(_ text: String) -> Bool
}

// MARK: - ValidatorImpl

public class ValidatorImpl: Validator {
    //  swiftlint:disable all

    private var emailRegex: String { "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}" }

    private var nameRegex: String { "^(([a-zA-Z?][a-zA-Z\\s?]{0,98}[a-zA-Z?])|([а-яА-Я?][а-яА-Я-\\s?]{0,98}[а-яА-Я?]))$" }

    //  swiftlint:enable all
    private var whiteSpacingRegex: String { "\\s{2}" }

    public init() {}

    public func isEmail(_ text: String) -> Bool {
        guard let regex = try? NSRegularExpression(self.emailRegex) else { return false }
        return regex.matches(text)
    }

    public func isPassword(_ text: String) -> Bool {
        text.count >= 6
    }

    public func isName(_ text: String) -> Bool {
        guard
            let nameRegex = try? NSRegularExpression(self.nameRegex),
            let whiteSpacingRegex = try? NSRegularExpression(self.whiteSpacingRegex)
        else { return false }
        return nameRegex.matches(text) && !whiteSpacingRegex.matches(text)
    }
}
