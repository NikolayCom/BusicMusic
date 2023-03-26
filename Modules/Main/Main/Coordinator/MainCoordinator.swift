import Core
import Common
import Models

final class MainCoordinator: BaseCoordinator {
    private var assembly: MainAssembly?

    init(assembly: MainAssembly) {
        self.assembly = assembly

        super.init(navigationController: assembly.rootAssembly.commonNavigation)
    }

    override func start() {
        guard let main = assembly?.makeMain(output: self) else { return }
        navigationController.pushViewController(main, animated: true)
    }

    private func removeChilds() {
        children.forEach {
            remove(child: $0)
        }
    }
}

// MARK: MainOutputInterface

extension MainCoordinator: MainOutputInterface {}
