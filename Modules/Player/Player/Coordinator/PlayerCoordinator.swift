import Core
import Common
import Models

public final class PlayerCoordinator: BaseCoordinator {
    private var assembly: PlayerAssembly?

    init(assembly: PlayerAssembly, navigation: UINavigationController) {
        self.assembly = assembly

        super.init(navigationController: navigation)
    }

    public override func start() {
        guard let player = assembly?.makePlayer(output: self) else { return }
        print(navigationController.topViewController)
        navigationController.present(player, animated: true)
    }

    private func removeChilds() {
        children.forEach {
            remove(child: $0)
        }
    }
}

// MARK: PlayerOutputInterface
extension PlayerCoordinator: PlayerOutputInterface {}
