import Foundation
import UIComponents

// MARK: - RootAssembly

public protocol RootAssembly {
    var commonNavigation: UINavigationController { get }
    var authNavigation: UINavigationController { get }

    func makeNewNavigation() -> UINavigationController
}

// MARK: - RootAssemblyImpl

public class RootAssemblyImpl: RootAssembly {
    public lazy var commonNavigation: UINavigationController = makeNewNavigation()

    public lazy var authNavigation: UINavigationController = makeNewNavigation()

    // MARK: -

    public init() {}

    public func makeNewNavigation() -> UINavigationController {
        UINavigationController()
    }
}
