import Core
import Common
import Models

public final class ArtistInfoCoordinator: BaseCoordinator {
    private var assembly: ArtistInfoAssembly?

    init(assembly: ArtistInfoAssembly) {
        self.assembly = assembly

        super.init(navigationController: assembly.rootAssembly.commonNavigation)
    }

    override public func start() {
        showArtistInfo()
    }

    private func removeChilds() {
        children.forEach {
            remove(child: $0)
        }
    }
}

// MARK: WidgetCoordinator
extension ArtistInfoCoordinator: WidgetCoordinator {
    public func addWidget(to homeViewController: UIViewController) {
        guard let childController = assembly?.makeArtistInfoWidget(output: self) else { return }
        homeViewController.addChild(childController)
        childController.didMove(toParent: homeViewController)
    }
}

// MARK: ArtistInfoWidgetOutputInterface
extension ArtistInfoCoordinator: ArtistInfoWidgetOutputInterface {
    public func showArtistInfo() {
        guard let artistInfo = assembly?.makeArtistInfo(output: self) else { return }
        assembly?.navigationController.pushViewController(artistInfo, animated: true)
    }
}

// MARK: ArtistInfoOutputInterface
extension ArtistInfoCoordinator: ArtistInfoOutputInterface {}
