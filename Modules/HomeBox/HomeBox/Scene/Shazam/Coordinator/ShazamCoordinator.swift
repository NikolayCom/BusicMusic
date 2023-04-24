import Core
import Common
import Models

final class ShazamCoordinator: BaseCoordinator {
    private var assembly: ShazamAssembly?

    init(assembly: ShazamAssembly) {
        self.assembly = assembly

        super.init(navigationController: assembly.rootAssembly.commonNavigation)
    }

    override func start() {
        guard let shazamWidget = assembly?.makeShazam(output: self) else { return }
        navigationController.pushViewController(shazamWidget, animated: true)
    }

    private func removeChilds() {
        children.forEach {
            remove(child: $0)
        }
    }
}

// MARK: WidgetCoordinator
extension ShazamCoordinator: WidgetCoordinator {
    func addWidget(to homeViewController: UIViewController) {
        guard let childController = assembly?.makeShazam(output: self) else { return }
        homeViewController.addChild(childController)
        childController.didMove(toParent: homeViewController)
    }
}

// MARK: ShazamOutputInterface
extension ShazamCoordinator: ShazamOutputInterface {
    func showShazamView() {
        guard let shazamSearch = assembly?.makeShazamSearch(output: self) else { return }
        assembly?.navigationController.pushViewController(shazamSearch, animated: true)
    }
}

// MARK: ShazamSearchOutputInterface
extension ShazamCoordinator: ShazamSearchOutputInterface {
    func showAddSong() {
        guard let addSong = assembly?.makeAddSong(output: self) else { return }
        assembly?.navigationController.present(addSong, animated: true)
    }
}

extension ShazamCoordinator: AddSongOutputInterface {
    func dismissScreen() {
        assembly?.navigationController.topViewController?.dismiss(animated: true)
    }
}
