import Core
import Common
import Models

final class MediaLibraryCoordinator: BaseCoordinator {
    private var assembly: MediaLibraryAssembly?

    init(assembly: MediaLibraryAssembly) {
        self.assembly = assembly

        super.init(navigationController: assembly.rootAssembly.commonNavigation)
    }

    override func start() {
        showLibrary()
    }

    private func removeChilds() {
        children.forEach {
            remove(child: $0)
        }
    }
}

// MARK: WidgetCoordinator
extension MediaLibraryCoordinator: WidgetCoordinator {
    func addWidget(to homeViewController: UIViewController) {
        guard let childController = assembly?.makeMediaLibraryWidget(output: self) else { return }
        homeViewController.addChild(childController)
        childController.didMove(toParent: homeViewController)
    }
}

// MARK: MediaLibraryOutputInterface
extension MediaLibraryCoordinator: MediaLibraryWidgetOutputInterface {
    func showLibrary() {
        guard let library = assembly?.makeMediaLibrary(output: self) else { return }
        assembly?.navigationController.pushViewController(library, animated: true)
    }
}

// MARK: MediaLibraryOutputInterface
extension MediaLibraryCoordinator: MediaLibraryOutputInterface {}
