import Core
import Common
import Models

public final class ProfileCoordinator: BaseCoordinator {
    private var assembly: ProfileAssembly?

    init(assembly: ProfileAssembly) {
        self.assembly = assembly

        super.init(navigationController: assembly.rootAssembly.commonNavigation)
    }

    public override func start() {
        guard let profile = assembly?.makeProfile(output: self) else { return }
        navigationController.pushViewController(profile, animated: true)
    }

    private func removeChilds() {
        children.forEach {
            remove(child: $0)
        }
    }
}

// MARK: ProfileOutputInterface
extension ProfileCoordinator: ProfileOutputInterface {
    public func showSplash() {
        navigationController.popToRootViewController(animated: true)
    }
}
