import Core
import Common
import Models

final class HomeBoxCoordinator: BaseCoordinator {
    private var assembly: HomeBoxAssembly?

    init(assembly: HomeBoxAssembly) {
        self.assembly = assembly

        super.init(navigationController: assembly.rootAssembly.commonNavigation)
    }

    override func start() {
        guard let homeBox = assembly?.makeHomeBox(output: self) else { return }
        navigationController.pushViewController(homeBox, animated: true)

        addWidgetsControllers(to: homeBox)
    }

    private func removeChilds() {
        children.forEach {
            remove(child: $0)
        }
    }
}

private extension HomeBoxCoordinator {
    private func addWidgetsControllers(to homeController: UIViewController) {
        HomeBoxWidget.allCases.forEach { widget in
            guard let widgetCoordinator = widgetController(for: widget) else { return }
            widgetCoordinator.addWidget(to: homeController)
            add(child: widgetCoordinator)
        }
    }

    private func widgetController(for widget: HomeBoxWidget) -> WidgetCoordinator? {
        switch widget {
        case .shazam:
            return assembly?.makeShazam(nvc: navigationController)

        case .myLibrary:
            return nil
        }
    }
}

// MARK: HomeBoxOutputInterface
extension HomeBoxCoordinator: HomeBoxOutputInterface {}
