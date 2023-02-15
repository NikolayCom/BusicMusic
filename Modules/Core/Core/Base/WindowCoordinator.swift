import UIKit

open class WindowCoordinator: BaseCoordinator {
    // MARK: - Coordinator Properties

    public let window: UIWindow

    // MARK: - Constructor

    public init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window

        super.init(navigationController: navigationController)
    }
}
