import Foundation

public struct Configuration {
    private enum Constants {
        enum PlistKeys {
            static let bundleAppName = "CFBundleExecutable"
        }
    }

    // MARK: Public

    public static var shared = Configuration.readConfig()

    public let appBundle: String
    public let appName: String

    public var isDebug: Bool {
        #if DEBUG || INT
            return true
        #else
            return false
        #endif
    }

    public var currentLanguageCode: String {
        get {
            UserDefaults.standard.string(forKey: "currentLanguage").orEmpty
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "currentLanguage")
        }
    }

    // MARK: Private methods

    private static func readConfig() -> Configuration {
        guard let infoDict = Bundle.main.infoDictionary else {
            fatalError("Unable to read config at info.plist file ")
        }
        let keys = Constants.PlistKeys.self
        guard
            let appBundle: String = Convert.from(Bundle.main.bundleIdentifier),
            let appName: String = Convert.get(key: keys.bundleAppName, from: infoDict)
        else {
            fatalError("Unable to convert config")
        }

        var config = Configuration(
            appBundle: appBundle,
            appName: appName
        )

        return config
    }
}
