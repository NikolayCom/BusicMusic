import Foundation
import UIKit

// MARK: String + Localizable

public struct LocalizedString {
    public let key: String?
    public let arguments: [String]

    public var localized: String? {
        guard let format = localizedValue() else { return self.localizedValue() }
        return String(format: format, arguments: self.arguments)
    }

    public init(key: String?, arguments: [String] = []) {
        self.key = key
        self.arguments = arguments
    }

    private func localizedValue() -> String? {
        guard let key = key else { return key }
        guard
            let languageCode = UserDefaults.standard.string(forKey: "currentLanguage"),
            let url = Bundle(identifier: "org.cocoapods.Resources")?.url(
                forResource: languageCode,
                withExtension: "lproj"
            ),
            let bundle = Bundle(url: url)
        else { return Bundle.main.localizedString(forKey: key, value: nil, table: "Localizable") }

        return bundle.localizedString(forKey: key, value: nil, table: "Localizable")
    }
}
