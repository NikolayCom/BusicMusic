import Core

final class AuthCoordinator: BaseCoordinator {
    private weak var assembly: AuthAssembly?

    init(assembly: AuthAssembly) {
        self.assembly = assembly

        super.init(navigationController: assembly.rootAssembly.commonNavigation)
    }

    override func start() {
        guard let splash = assembly?.makeSplash(output: self) else { return }
        navigationController.setViewControllers([splash], animated: true)
    }

    private func removeChilds() {
        children.forEach {
            remove(child: $0)
        }
    }
}

// MARK: SplashOutputInterface

extension AuthCoordinator: SplashOutputInterface {}

